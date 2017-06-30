#requires -version 4

Clear-Host

    #$encoding = [system.Text.Encoding]::UTF8

    $OuName = 'Fougeres-sur-Bievre'
    $GroupeName = 'Forgeron'
    $Nom = 'Nom F'
    $Prenom = 'Prenom F'
    $Login = 'f.fsb'
    $Email = 'f.fsb@gmail.com'
    $Password = ConvertTo-SecureString 'P@ssW0rd' -AsPlainText -Force;

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

$group.DistinguishedName;

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
