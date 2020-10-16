# Installation silencieuse de Mozilla Firefox ESR (win64)
# URL: https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win64&lang=fr

# Définition d'un répertoire de travail pour le téléchargement et l'installation
$workdir = "$env:TEMP"

# Récupérer la dernière version du webbrowser

$source = "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win64&lang=fr"
$destination = "$workdir\firefox.exe"

# Arrête le script si l'utilisateur n'a pas le rôle d'administrateur
$myCurrentUser = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-not $myCurrentUser.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )) {
    Write-Host "Merci de lancer ce script en tant qu'administrateur." -ForegroundColor Red
    exit
}

# Test si le cmdlet Invoke-Webrequest existe 
# A défaut, on utilise la classe WebClient
if (Get-Command 'Invoke-Webrequest')
{
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}

# Démarrer l'installation
Start-Process -FilePath "$workdir\firefox.exe" -ArgumentList "/S"

# Attendre 35 secondes la fin de l'installation
Start-Sleep -s 35

# Supprimer le programme d'installation
rm -Force $workdir\firefox*