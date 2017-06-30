#requires -version 4

cls

# Défini le mode d'erreur par défaut
$ErrorActionPreference = 'stop';
$Error.Clear();

# Nom du fichier à importer
$fileName = ".\users6.csv";

# Test l'existence du fichier
if(!(Test-Path $fileName)) {
    Write-Host "Le fichier $fileName n'existe pas" -ForegroundColor DarkRed;
    Exit 0
}

# Import du fichier CSV
$data = Import-Csv -Path $fileName -Delimiter ';';

# Parcours des lignes
foreach($row in $data) {

    # Récupération des données de la ligne
    $OuName = $row.Ville
    $GroupeName = $row.Metier
    $Nom = $row.Nom
    $Prenom = $row.Prenom
    $Login = $row.Login
    $Email = $row.Email

    #Write-Host "$OuName, $GroupeName, $Nom, $Prenom, $Login, $Email"

}
