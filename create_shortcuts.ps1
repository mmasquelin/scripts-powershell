# Demo pour création d'un raccourci avec WinPS
$sourceFileLocation = "$env:SystemRoot\System32\notepad.exe"
$shortcutLocation = "C:\Users\PIT\Desktop\Notepad.lnk"

# New-Object : utilisé pour créer des objets .NET et COM
# -ComObject WScript.Shell : créer un objet de type COM de type WScript.Shell pour appeler la méthode CreateShortCut
$WScriptShell = New-Object -ComObject WScript.Shell

$shortcut = $WScriptShell.CreateShortcut($shortcutLocation)
$shortcut.TargetPath = $sourceFileLocation

# Sauvegarder le raccourci à l'emplacement défini (cf. TargetPath)
$shortcut.Save()