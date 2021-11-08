#Requires -Version 5

function abort($msg, [int] $exit_code=1) {
    Write-Host $msg -f red
    exit $exit_code
}

function doing($msg) {
    Write-Host "> $msg" -f cyan
}

function info($msg) {
    Write-Host "$msg" -f darkgray
}

function notice($msg) {
    Write-Host "$msg" -f yellow
}

function reboot($msg) {
    notice "$msg"
    notice ""
    Restart-Computer -Confirm
}

function commandMissing {
    param (
        [string]$name
    )

    return [boolean]!(Get-Command $name -ErrorAction Ignore)
}

function invokeURL {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$url,

        [string[]]
        [Parameter(Position=1, ValueFromRemainingArguments)]
        $arguments
    )

    info "... ${url}"

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


function sanitizeGit {
    $default = @{
        username = $env:username
        email    = "$($env:username)@$($env:userdomain)"
    }

    $user = git config --global user.name | Out-String

    if ($user -eq "") {
        notice "Git username '$($default["username"])' olarak ayarlandi."
        notice "Lutfen bunu daha sonra asagidaki komutla degistirin:"
        notice "    git config --global user.name <KULLANICIADI>"

        git config --global user.name $default["username"]
    }

    $email = git config --global user.email | Out-String

    if ($email -eq "") {
        notice "Git email '$($default["email"])' olarak ayarlandi."
        notice "Lutfen bunu daha sonra asagidaki komutla degistirin:"
        notice "    git config --global user.email <EMAIL>"

        git config --global user.email $default["email"]
    }
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

    if (commandMissing "scoop") {
        doing "Scoop kuruluyor"

        invokeURL("get.scoop.sh")
    }

    if (commandMissing "git") {
        doing "Git kuruluyor"

        scoop install git
    }

    doing "Git kurulumu kontrol ediliyor"
    sanitizeGit

    $buckets = @{
        'extras'     = ''
        'nerd-fonts' = ''
        'wsl'        = 'https://git.irs.sh/KNOXDEV/wsl'
    }

    foreach ($bucket in $buckets.GetEnumerator()) {
    	if (!(scoop bucket list | Select-String -Pattern $bucket.Name -Quiet)) {
            info "Scoop bucket ekleniyor: $($bucket.Name)"

            scoop bucket add $bucket.Name $bucket.Value
        }
    }

    if (commandMissing "code") {
        doing "VS Code kuruluyor"

        scoop install vscode
    }

    if (!(scoop export | Select-String -Pattern "wsl-ubuntu2004" -Quiet)) {
        doing "Ubuntu kutusu kuruluyor"

        scoop install wsl-ubuntu2004
    }

    if (!(enabledWindowsOptionalFeature "VirtualMachinePlatform") -or !(enabledWindowsOptionalFeature "Microsoft-Windows-Subsystem-Linux")) {
        doing "Windows Linux Alt Sistemi (WSL) aktive ediliyor"

        if (!(enabledWindowsOptionalFeature "VirtualMachinePlatform")) {
            Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
        }

        if (!(enabledWindowsOptionalFeature "Microsoft-Windows-Subsystem-Linux")) {
            Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
        }

        reboot("Makinenin yeniden baslatilmasi gerekiyor.  Lutfen islemi onaylayin.")
    }

    $erroractionpreference = $old_erroractionpreference # Reset $erroractionpreference to original value
}

main
