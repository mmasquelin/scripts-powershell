$homepageURL = 'https://www.cristal.univ-lille.fr'

# HKEY_CLASSES_ROOT n'existe pas, on le déclare
# C'est un alias pour HKLM\SOFTWARE\Classes et HKCU\SOFTWARE\Classes
# Cf. http://msdn.microsoft.com/en-us/library/windows/desktop/ms724498(v=vs.85).aspx
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

# Configurer la page d'accueil pour IE
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\main' -Name 'Start Page' -Value $homepageURL

# Configurer la page d'accueil pour Edge (ancienne version)
Set-ItemProperty -Path 'HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main' -Name 'HomeButtonEnabled' -type 'DWord' -value '00000001'
Set-ItemProperty -Path 'HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main' -Name 'HomeButtonPage' -value 'https://www.cristal.univ-lille.fr'

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