# Installation silencieuse de Google Chrome (x64)
# URL: https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi

Write-Host 'Ce script va installer Google Chrome...'

# Définition d'un répertoire de travail pour le téléchargement et l'installation
$workdir = "$env:TEMP"
$preferencesFileLocation = "https://raw.githubusercontent.com/mmasquelin/scripts-powershell/browsers/extras/master_preferences"

# Récupérer la dernière version du webbrowser 
# Fait en fonction du type d'OS (32/64 bits)
if (Test-Connection dl.google.com -Count 3 -Quiet) {
    if (!([Environment]::Is64BitOperatingSystem)) {
        $source = "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi"
    } else {
        $source = "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi"
    }
    $destination = "$workdir\Chrome.msi"

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
        Invoke-WebRequest $preferencesFileLocation -OutFile "$workdir\master_preferences"
    }
    else
    {
        $WebClient = New-Object System.Net.WebClient
        $WebClient.DownloadFile($source, $destination)

        $OthWebCli = New-Object System.Net.WebClient
        $OthWebCli.DownloadFile($preferencesFileLocation, "$workdir\master_preferences")
    }
} else {
    Write-Host 'Echec. Impossible de joindre dl.google.com' -ForegroundColor Red
    exit
}

# Définir une liste des processus à tuer
$processesToStop = @(
"chrome*"
)

# Arrêter les processus avant l'installation
foreach ($ProcToStop in $processesToStop){
    Get-process $ProcToStop -EA SilentlyContinue |Stop-Process -FOrce
}

$ChromeMSI = """$destination"""

# Démarrer l'installation
Start-Process -filepath msiexec -argumentlist "/i $ChromeMSI /qn /norestart" -Wait -PassThru

$Process2Monitor =  "ChromeInstaller"; 
Do { 
    $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; 
    If ($ProcessesFound) 
        { "En cours d'exécution: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } 
    else
    { rm -Force "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } 
} Until (!$ProcessesFound)

Write-Host 'Configuration accueil du navigateur...'
If ((Test-Path "C:\Program Files\Google\Chrome\Application\chrome.exe") -eq $True) {
    Copy-Item -Path "$workdir\master_preferences" -Destination "C:\Program Files\Google\Chrome\Application\"
} else {
    Copy-Item -Path "$workdir\master_preferences" -Destination "C:\Program Files (x86)\Google\Chrome\Application\"
}

# Supprimer le programme d'installation et les préférences
rm -Force $workdir\Chrome*
rm -Force $workdir\master_preferences