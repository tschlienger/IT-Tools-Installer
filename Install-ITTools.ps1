If (Not(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

$Packages = Import-Csv "$PSScriptRoot\tools.csv"

Foreach ($Package in $Packages) {
    choco install $Package.Item -y
}