cls

# Récupère la liste des PC de l'AD
$computer = (Get-ADComputer -Filter *).name

# Boucle sur chaque PC ded l'AD
foreach($pc in $computer){

    Write-Host
    Write-Host 'Liste des services sur : ' $pc -ForegroundColor green

    if($pc -eq $env:COMPUTERNAME) {
        # Il ne faut pas utiliser la session
        # distante pour le PC local
        Get-Service
    }
    else {
        # Ouverture d'une session sur le PC distant
        $session = New-PSSession -ComputerName $pc
        # Récupère la liste des service sur le Pc distant
        Invoke-Command -Session $session -ArgumentList $pc -ScriptBlock {
            Param($refpc)
            Write-Host 'Liste des services sur : ' $refpc 
            Get-Service -ComputerName $refpc
        }
        # Fermeture de la session
        Remove-PSSession $session
    }

}

