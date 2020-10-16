$homepageURL = 'https://www.cristal.univ-lille.fr'

# Arrête le script si l'utilisateur n'a pas le rôle d'administrateur
$myCurrentUser = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-not $myCurrentUser.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )) {
    Write-Host "Merci de lancer ce script en tant qu'administrateur." -ForegroundColor Red
    exit
}

# Configurer la page d'accueil pour Google Chrome
if ((Test-Path HKLM:\SOFTWARE\Policies\Google\Chrome) -eq $false) {
    New-Item -path HKLM:\SOFTWARE\Policies\Google
    New-Item -path HKLM:\SOFTWARE\Policies\Google\Chrome
    New-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name RestoreOnStartup -PropertyType Dword -Value 4
    New-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name HomepageLocation -PropertyType String -Value $homepageURL
    New-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name HomepageIsNewTabPage -PropertyType DWord -Value 0
} else {
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name RestoreOnStartup -PropertyType Dword -Value 4
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name HomepageLocation -PropertyType String -Value $homepageURL
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name HomepageIsNewTabPage -PropertyType DWord -Value 0
}

if ((Test-Path HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs) -eq $false) {
    New-Item -Path HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs' -Name 1 -PropertyType String -Value $homepageURL
} else {
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs' -Name 1 -Value $homepageURL
}