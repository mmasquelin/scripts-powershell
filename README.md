# Scripts Windows PowerShell

Collection de scripts écrits avec Windows PowerShell

> Note : Le script `setup_google_chrome_homepage.ps1` s'exécute mais les modifications ne sont pas appliquées au profil Google Chrome de l'utilisateur. C'est donc à creuser ...

## Utilisation

Par défaut, l'exécution des scripts Windows PowerShell n'est pas autorisée par Microsoft Windows 10. 

Les étapes ci-après sont nécessaires pour autoriser ces opérations : 

1. Ouvrir un terminal en ligne de commandes ( Win + R )
2. Ouvrir l'éditeur de stratégies de groupe ( gpedit.msc )
3. Aller à l'emplacement : Stratégie Ordinateur local -> Configuration ordinateur -> Modèles d'administration -> Composants Windows -> Windows PowerShell
4. Positionner l'item "Activer l'exécution des scripts" à la valeur "Activé"
5. Positionner le paramètre de stratégie d'exécution sur "Autoriser les scripts locaux et les scripts signés distants"

## Exemple d'utilisation

Il est nécessaire de lancer un invite de commandes PowerShell :

```
PS Z:\Dev\scripts-powershell> .\Hello_world.ps1
```
