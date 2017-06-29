
# Création d'une nouvelle session
$session = New-PSSession -ComputerName $env:COMPUTERNAME


# Création d'une nouvelle session en changeant d'utilisateur
# Récupération du crédential auprès de l'utilisateur 
$credential = Get-Credential -Message 'Mon message ici' -UserName $env:USERNAME
$session = New-PSSession -ComputerName $env:COMPUTERNAME -Credential $credential


# fermeture de la session
Remove-PSSession -Session $session

