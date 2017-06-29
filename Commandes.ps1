Exemple de commandes :

# R�cup�re une variable d'environnement
$env:USERNAME

# Vesion de PowerShell
$PSVersionTable

# Liste les fichier d'un r�pertoire (comme dir)
# Fait un tri descendant en fonction de Name
# Selectionne les 10 premiers
# Exporte dans le fichier c:\temp.txt
Get-ChildItem C:\Windows | Sort-Object Name -Descending | Select-Object -First 10 > c:\temp.txt

# Get-Member
# Permet de retrouver les membres d'une fonction
# Retrouves les membres de la commande Get-Alias
Get-Alias | Get-Member


# R�cup�re la liste des commandes
# extraction de l'aide sans tenir compte des erreurs
# ne r�cup�re que les champs Name et Synopsis
# Converti au format Html en indiquant un titre ("" interpr�te le contenu de la chaine, '' n'est pas interpr�t�)
Get-Command -CommandType Cmdlet | Get-Help -ErrorAction SilentlyContinue | select Name, Synopsis | ConvertTo-Html -Title "Mon Aide : $env:USERNAME" > c:\ps.html

