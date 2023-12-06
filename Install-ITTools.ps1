If (-Not(Get-Command winget)) {
    exit 1
}

#If (-Not(Get-Command choco)) {
#    exit 1
#}

$ToolList = Import-Csv "$PSScriptRoot\tools.csv"

Foreach ($Tool in $ToolList) {
    Write-Host "Installing $($Tool.DisplayName)" -ForegroundColor Blue
    Switch ($Tool.PackageManager) {
        "winget" {
            If ($Tool.Version -ne "") {
                winget install $Tool.PackageName -v $Tool.Version -s winget
            }
            Else {
                winget install $Tool.PackageName -s winget
            }
        }
        "choco" {
            If ($Tool.Version -ne "") {
                choco install $Tool.PackageName --version=$Tool.Version -y
            }
            Else {
                choco install $Tool.PackageName -y
            }
        }
    }
    winget install $Tool.PackageName -s winget
}
