Try {
    If (Get-Command winget) {
        return $true
    }
}
Catch {
    write-host "WinGet is not installed. Please install it and try again." -ForegroundColor Red
    start-process -FilePath "https://aka.ms/getwinget"
    exit 1
}

Try {
    If (Get-Command choco) {
        return $true
    }
}
Catch {
    write-host "Chocolatey is not installed. Please install it and try again." -ForegroundColor Red
    start-process -FilePath "https://chocolatey.org/install"
    exit 1
}

$ToolList = Import-Csv "$PSScriptRoot\tools.csv"

Foreach ($Tool in $ToolList) {
    Switch ($PackageManager) {
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