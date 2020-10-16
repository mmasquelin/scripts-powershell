# Ne fonctionne pas via clefs de registre ?
$homepageURL = 'https://www.cristal.univ-lille.fr'

# Arrête le script si l'utilisateur n'a pas le rôle d'administrateur
$myCurrentUser = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-not $myCurrentUser.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )) {
    Write-Host "Merci de lancer ce script en tant qu'administrateur." -ForegroundColor Red
    exit
}

# Configurer la page d'accueil pour Google Chrome
if (Test-Path HKLM:\SOFTWARE\Policies\Google\Chrome) {
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name RestoreOnStartup -Type 'Dword' -Value 4
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name HomepageLocation -Type 'String' -Value $homepageURL
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name HomepageIsNewTabPage -Type 'DWord' -Value 0
} else {
    New-Item -path HKLM:\SOFTWARE\Policies\Google
    New-Item -path HKLM:\SOFTWARE\Policies\Google\Chrome
    New-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name RestoreOnStartup -Type 'Dword' -Value 4
    New-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name HomepageLocation -Type 'String' -Value $homepageURL
    New-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name HomepageIsNewTabPage -Type 'DWord' -Value 0
}

if (Test-Path HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs) {
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs' -Name 1 -Value $homepageURL
} else {
    New-Item -Path HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs' -Name 1 -Type 'String' -Value $homepageURL
}