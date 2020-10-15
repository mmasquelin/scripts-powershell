# Demo pour création d'un raccourci avec WinPS
# $sourceFileLocation = "$env:SystemRoot\System32\notepad.exe"
$sourceFileLocation = "$env:Programfiles\Mozilla Firefox\firefox.exe"

$shortcutLocation01 = "$home\Desktop\AppSi.lnk"
$shortcutLocation02 = "$home\Desktop\Salles CRIStAL.lnk"

# New-Object : utilisé pour créer des objets .NET et COM
# -ComObject WScript.Shell : créer un objet de type COM de type WScript.Shell pour appeler la méthode CreateShortCut
$WScriptShell = New-Object -ComObject WScript.Shell

$shortcut = $WScriptShell.CreateShortcut($shortcutLocation01)
$shortcut.TargetPath = $sourceFileLocation
$shortcut.Arguments = "https://appsi.lifl.fr/"

# Sauvegarder le raccourci à l'emplacement défini (cf. TargetPath)
$shortcut.Save()

$shortcut = $WScriptShell.CreateShortcut($shortcutLocation02)
$shortcut.TargetPath = $sourceFileLocation
$shortcut.Arguments = "-kiosk https://salles.cristal.univ-lille.fr/Web/"

# Sauvegarder le raccourci à l'emplacement défini (cf. TargetPath)
$shortcut.Save()