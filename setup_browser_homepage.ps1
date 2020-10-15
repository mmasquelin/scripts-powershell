$homepageURL = 'https://www.cristal.univ-lille.fr'

# HKEY_CLASSES_ROOT n'existe pas, on le déclare
# C'est un alias pour HKLM\SOFTWARE\Classes et HKCU\SOFTWARE\Classes
# Cf. http://msdn.microsoft.com/en-us/library/windows/desktop/ms724498(v=vs.85).aspx
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

# Configurer la page d'accueil pour IE
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\main' -Name 'Start Page' -value $homepageURL

# Configurer la page d'accueil pour Edge (ancienne version)
Set-ItemProperty -Path 'HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main' -Name 'HomeButtonEnabled' -type 'DWord' -value '00000001'
Set-ItemProperty -Path 'HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main' -Name 'HomeButtonPage' -value 'https://www.cristal.univ-lille.fr'