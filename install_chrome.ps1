# Installation silencieuse de Mozilla Firefox ESR (win64)
# URL: https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi

# Définition d'un répertoire de travail pour le téléchargement et l'installation
$workdir = "$env:TEMP"

# Récupérer la dernière version du webbrowser

$source = "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi"
$destination = "$workdir\googlechromestandaloneenterprise64.msi"

# Test si le cmdlet Invoke-Webrequest existe 
# A défaut, on utilise la classe WebClient
if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}

# Démarrer l'installation
Start-Process msiexec.exe -Wait -ArgumentList '/x $workdir\googlechromestandaloneenterprise64.msi /silent /install'

# Attendre 35 secondes la fin de l'installation
# Start-Sleep -s 35

# Supprimer le programme d'installation
# rm -Force $workdir\ChromeInstaller*


$Process2Monitor =  "ChromeInstaller"; 
Do { 
    $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; 
    If ($ProcessesFound) 
        { "En cours d'exécution: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } 
    else
    { rm -Force "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } 
} Until (!$ProcessesFound)