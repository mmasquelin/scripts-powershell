# Arrêter firefox
Get-Process -Name firefox -ErrorAction Ignore | Stop-Process -Force
Start-Sleep -Seconds 1

# Récupérer la liste des profils utilisateurs sur la machine
$String = (Get-Content -Path "$env:APPDATA\Mozilla\Firefox\installs.ini" | Select-String -Pattern "^\s*Default\s*=\s*.+" | ConvertFrom-StringData).Default
$profileName = Split-Path -Path $String -Leaf

# Définition d'un répertoire de travail pour le téléchargement et l'installation
$workdir = "$env:TEMP"

# Récupérer le fichier user.js depuis le web
if (Test-Connection raw.githubusercontent.com -Count 3 -Quiet) {
    $source = "https://aw.githubusercontent.com/mmasquelin/scripts-powershell/browsers/extras/user.js"
    $destination = "$workdir\user.js"

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
        $WebClient.DownloadFile($source, $destination)
    }
} else {
    Write-Host 'Echec. Impossible de joindre raw.githubusercontent.com' -ForegroundColor Red
    exit
}

If ((Test-Path "$env:APPDATA\Mozilla\Firefox\Profiles\$profileName") -eq $True) {
    Copy-Item -Path "$workdir\user.js" -Destination "$env:APPDATA\Mozilla\Firefox\Profiles\$profileName"
} else {
    Copy-Item -Path "$workdir\user.js" -Destination "$env:APPDATA\Mozilla\Firefox\Profiles\$profileName"
}

# Supprimer le programme d'installation et les préférences
rm -Force $workdir\user.js