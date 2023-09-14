# Function to process multiple WinGet Installs
# Usage: Winget-Install Package1.Package1,Package2.Package2

function Winget-Install {
  Param(
		# List of packages to upgrade
		[Parameter(Position = 0, Mandatory = $true)]
		[string[]] $Packages
	)
	foreach ($Package in $Packages) {
		$Package = $Package.Trim()
		Write-Host ('Upgrading {0}...' -f $Package) -ForegroundColor Green
		WinGet install --accept-package-agreements $Package
	}
}

Winget-Install Notepad++.Notepad++,7zip.7zip,Microsoft.WindowsTerminal,Microsoft.PowerShell,DominikReichl.KeePass,Google.Chrome,Microsoft.VisualStudioCode
