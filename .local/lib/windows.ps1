#Requires -Version 5

function abort($msg, [int] $exit_code=1) {
    Write-Host $msg -f red
    exit $exit_code
}

function doing($msg) {
    Write-Host "> $msg" -f yellow
}

function info($msg) {
    Write-Host "$msg" -f darkgray
}

function commandMissing {
    Param (
        [string]$name
    )

    return [boolean]!(Get-Command $name -ErrorAction Ignore)
}

function invokeURL {
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$url,

        [string[]]
        [Parameter(Position=1, ValueFromRemainingArguments)]
        $arguments
    )

    info "... Running script from ${url}"

    # Set TLS1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"
    & $([scriptblock]::Create((Invoke-RestMethod $url))) @arguments
}

function main() {
    $old_erroractionpreference = $erroractionpreference
    $erroractionpreference = 'stop' # quit if anything goes wrong

    $allowedExecutionPolicy = @('Unrestricted', 'RemoteSigned', 'ByPass')
    if ((Get-ExecutionPolicy).ToString() -notin $allowedExecutionPolicy) {
        Write-Output "PowerShell requires an execution policy in [$($allowedExecutionPolicy -join ", ")] to run this script."
        Write-Output "For example, to set the execution policy to 'RemoteSigned' please run :"
        Write-Output "'Set-ExecutionPolicy RemoteSigned -scope CurrentUser'"
        break
    }

    if (commandMissing "scoop") {
        doing "Installing Scoop"

        invokeURL("get.scoop.sh")
    }

    if (commandMissing "git") {
        doing "Installing Git"

        scoop install git
        git config --global credential.helper manager-core
    }

    $buckets = @{
        "extras"     = ""
        "nerd-fonts" = ""
        "wsl"        = "https://git.irs.sh/KNOXDEV/wsl"
    }

    foreach ($bucket in $buckets.GetEnumerator()) {
        if (scoop bucket known | Select-String -Pattern "^$($bucket.Name)$" -Quiet) {
            doing "Adding Scoop bucket $bucket"

            scoop bucket add $bucket.Name $bucket.Value
        }
    }

    if (commandMissing "code") {
        doing "Installing VS Code"

        scoop install vscode
    }

    if (!(scoop info wsl-ubuntu2004 *>$null)) {
        doing "Downloading Ubuntu WSL image"

        scoop install wsl-ubuntu2004
    }

    $erroractionpreference = $old_erroractionpreference # Reset $erroractionpreference to original value

    doing "Enabling WSL"

    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
}

main
