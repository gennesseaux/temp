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
    $OuName = 'Fougères-sur-Bièvre' #$row.Ville
    $GroupeName = $row.Metier
    $Nom = $row.Nom
    $Prenom = $row.Prenom
    $Login = $row.Login
    $Email = $row.Email
    $Password = ConvertTo-SecureString 'P@ssW0rd' -AsPlainText -Force;

    #Write-Host "$OuName, $GroupeName, $Nom, $Prenom, $Login, $Email"

    $ou = Get-ADOrganizationalUnit -Filter {Name -eq $OuName}

    if($ou -eq $null) {
        $ou = New-ADOrganizationalUnit `
                -Name $OuName `
                -ProtectedFromAccidentalDeletion $false `
                -Path "ou=Powershell,dc=stage,dc=local" `
                -PassThru 
    }

    $Path = $ou.DistinguishedName;

    $group = Get-ADGroup -Filter {SamAccountName -eq $GroupeName}
    if($group -eq $null) {
        $group = New-ADGroup `
                    -Name $GroupeName `
                    -SamAccountName $GroupeName `
                    -GroupCategory Security `
                    -GroupScope Global `
                    -Path $Path `
                    -PassThru
    }

    #$group.DistinguishedName;

    $user = Get-ADUser -Filter {SamAccountName -eq $Login}
    if($user -eq $null) {
        $user = New-ADUser `
                    -Name "$Nom $Prenom" `
                    -DisplayName "$Nom $Prenom" `
                    -Surname $Nom `
                    -GivenName $Prenom `
                    -EmailAddress $Email `
                    -SamAccountName $Login `
                    -AccountPassword $Password `
                    -ChangePasswordAtLogon $true `
                    -Enabled $true `
                    -Path $Path `
                    -PassThru

        Add-ADGroupMember -Identity $GroupeName -Members $Login
    }
    else {
        $member = Get-ADGroupMember -Identity $GroupeName | Where-Object {$_.SamAccountName -eq $Login}
        if($member -eq $null) {
            Add-ADGroupMember -Identity $GroupeName -Members $Login
        }
    }
}
