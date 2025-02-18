#Requires -Version 5

# KEEP THIS SCRIPT IDEMPOTENT

function abort($msg, [int] $exit_code=1) {
    Write-Host $msg -f red
    exit $exit_code
}

function doing($msg) {
    Write-Host "> $msg" -f cyan
}

function info($msg) {
    Write-Host "> $msg" -f darkgray
}

function notice($msg) {
    Write-Host "$msg" -f yellow
}

function reboot($msg) {
    notice "$msg"
    notice ""
    Restart-Computer -Confirm
}

function commandAvailable {
    param (
        [string]$name
    )

    return [boolean](Get-Command $name -ErrorAction Ignore)
}

function packageAvailable {
    param (
        [string]$name
    )

    return [boolean](scoop export | Select-String -Pattern $name -Quiet)
}

function bucketAvailable {
    param (
        [string]$name
    )

    return [boolean](scoop bucket list | Select-String -Pattern $name -Quiet)
}

function invokeURL {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$url,

        [string[]]
        [Parameter(Position=1, ValueFromRemainingArguments)]
        $arguments
    )

    info $url

    # Set TLS1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"
    & $([scriptblock]::Create((Invoke-RestMethod $url))) @arguments
}

# Credits: https://stackoverflow.com/a/37353046
function enabledWindowsOptionalFeature {
    param (
        [Parameter(Position=0, Mandatory=$true)] [string]$feature
    )

    return [boolean]((Get-WindowsOptionalFeature -FeatureName $feature -Online).State -eq "Enabled")
}

$global:tasksDone = 0

function taskScoopInstall {
    if (commandAvailable "scoop") {
	    return
    }

    doing "Scoop kuruluyor"
    invokeURL("get.scoop.sh")

    $global:tasksDone++
}

function taskGitInstall {
    if (commandAvailable "git") {
        return
    }

    doing "Git kuruluyor"
    scoop install git

    $global:tasksDone++
}

function taskGitSetup {
    $default = @{
        username = $env:username
        email    = "$($env:username)@$($env:userdomain)"
    }

    $user  = git config --global user.name  | Out-String
    $email = git config --global user.email | Out-String

    if (($user -ne "") -and ($email -ne "")) {
        return
    }

    doing "Git kurulumu kontrol ediliyor"

    if ($user -eq "") {
        notice "Git username '$($default["username"])' olarak ayarlandi."
        notice "Lutfen bunu daha sonra asagidaki komutla degistirin:"
        notice "    git config --global user.name <KULLANICIADI>"

        git config --global user.name $default["username"]
    }

    if ($email -eq "") {
        notice "Git email '$($default["email"])' olarak ayarlandi."
        notice "Lutfen bunu daha sonra asagidaki komutla degistirin:"
        notice "    git config --global user.email <EMAIL>"

        git config --global user.email $default["email"]
    }

    $global:tasksDone++
}

function taskScoopSetup {
    $buckets = @{
        'extras'     = ''
        'nerd-fonts' = ''
        'wsl'        = 'https://git.irs.sh/KNOXDEV/wsl'
    }

    $missings = [System.Collections.ArrayList]@()

    foreach ($bucket in $buckets.GetEnumerator()) {
    	if (!(bucketAvailable $bucket.Name)) {
            [void]$missings.Add($bucket)
        }
    }

    if ($missings.count -eq 0) {
        return
    }

    doing "Scoop bucket ekleniyor"

    foreach ($bucket in $missings) {
        info $bucket.Name

        scoop bucket add $bucket.Name $bucket.Value
    }

    $global:tasksDone++
}

function taskVSCodeInstall {
    if (commandAvailable "code") {
        return
    }

    doing "VS Code kuruluyor"
    scoop install vscode

    $global:tasksDone++
}

function taskWindowsTerminalInstall {
    if (commandAvailable "WindowsTerminal") {
        return
    }

    doing "Windows Terminal kuruluyor"
    scoop install windows-terminal

    $global:tasksDone++
}

function taskUbuntuInstall {
    if (packageAvailable "wsl-ubuntu2004") {
        return
    }

    doing "Ubuntu kutusu kuruluyor"
    scoop install wsl-ubuntu2004

    $global:tasksDone++
}

function taskWSL1Enable {
    $enabledWSL = enabledWindowsOptionalFeature "Microsoft-Windows-Subsystem-Linux"

    if ($enabledWSL) {
        return
    }

    doing "Windows Linux Alt Sistemi (WSL) versiyon 1 aktive ediliyor"

    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart
    reboot("Makinenin yeniden baslatilmasi gerekiyor.  Lutfen islemi onaylayin.")

    $global:tasksDone++
}

# Too many problems in older systems which can't be managed automatically in a robust manner
function taskWSL2Enable {
    info "Bu gorev henuz eklenmedi"

    return

    doing "Windows Linux Alt Sistemi (WSL) versiyon 2 aktive ediliyor"

    $global:tasksDone++
}

function main() {
    $old_erroractionpreference = $erroractionpreference
    $erroractionpreference = 'stop' # quit if anything goes wrong

    $allowedExecutionPolicy = @('Unrestricted', 'RemoteSigned', 'ByPass')
    if ((Get-ExecutionPolicy).ToString() -notin $allowedExecutionPolicy) {
        Write-Output "Kurulum betigi yeterli calistirma iznine sahip degil."
        Write-Output "Lutfen once asagidaki komutu calistirarak islemi tekrar edin:"
        Write-Output "'Set-ExecutionPolicy RemoteSigned -scope CurrentUser'"
        return
    }

    notice "Kurulum inceleniyor..."

    taskScoopInstall
    taskGitInstall
    taskGitSetup
    taskScoopSetup
    taskVSCodeInstall
    taskWindowsTerminalInstall
    taskUbuntuInstall
    taskWSL1Enable

    if ($global:tasksDone -eq 0) {
        notice "Kurulum sorunsuz."
    }

    $erroractionpreference = $old_erroractionpreference # Reset $erroractionpreference to original value
}

main
