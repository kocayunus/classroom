[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter',      '', Target='*')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression', '', Target='*')]

param (
    $Command
)

$Dispatch = @{
    "bootstrap" = [PSCustomObject]@{ Command = "Bootstrap"; Description = "Bootstrap system" }
    "hello"     = [PSCustomObject]@{ Command = "Hello";     Description = "Say hello"        }
}

$Packages  = @(
    "vscode"
    "windows-terminal"
)

function invokeURL {
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$url,

        [string[]]
        [Parameter(Position=1, ValueFromRemainingArguments)]
        $arguments
    )

    Write-Output "Running script from ${url}"

    # Set TLS1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"
    & $([scriptblock]::Create((Invoke-RestMethod $url))) @arguments
}

function Bootstrap() {
    [CmdletBinding()]
    Param()

    Write-Output "--- Bootstrap"

	Set-ExecutionPolicy Bypass -Scope Process -force

    Write-Output "... Installing Scoop"

	invokeURL("get.scoop.sh")

    Write-Output "... Installing Git"

    scoop install git
 	git config --global credential.helper manager-core

    Write-Output "... Configuring Scoop"

	scoop bucket add extras
	scoop bucket add nerd-fonts
	scoop bucket add wsl https://git.irs.sh/KNOXDEV/wsl

	scoop update

    Write-Output "... Installing extra packages"

    foreach ($package in $Packages) {
        Write-Output "${package}"
        scoop install $package
    }

    Write-Output "... Downloading Ubuntu WSL image"

	scoop install wsl-ubuntu2004

    Write-Output "... Enabling WSL"

	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
}

function Hello() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Name
    )
    Write-Output "--- Hello"
    Write-Output $Name
}

function usage() {
    $Dispatch.Values | Sort-Object -Descending
}

function main() {
    if (!$Command) {
        usage
        return
    }

    if ($Command -eq "help") {
        Get-Help $args[0]
        return
    }

    if (!$Env:OS.StartsWith("Win")) {
        Write-Error "This script requires Windows" -ErrorAction Stop
    }

    if (!$Dispatch.ContainsKey($Command)) {
        Write-Error "No such command: $Command" -ErrorAction Stop
    }

    & $Dispatch[$Command].Command @args
}

main @args
