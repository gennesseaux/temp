Exemple de commandes :

# Récupère une variable d'environnement
$env:USERNAME

# Vesion de PowerShell
$PSVersionTable

# Liste les fichier d'un répertoire (comme dir)
# Fait un tri descendant en fonction de Name
# Selectionne les 10 premiers
# Exporte dans le fichier c:\temp.txt
Get-ChildItem C:\Windows | Sort-Object Name -Descending | Select-Object -First 10 > c:\temp.txt

# Get-Member
# Permet de retrouver les membres d'une fonction
# Retrouves les membres de la commande Get-Alias
Get-Alias | Get-Member


# Récupère la liste des commandes
# extraction de l'aide sans tenir compte des erreurs
# ne récupère que les champs Name et Synopsis
# Converti au format Html en indiquant un titre ("" interprète le contenu de la chaine, '' n'est pas interprété)
Get-Command -CommandType Cmdlet | Get-Help -ErrorAction SilentlyContinue | select Name, Synopsis | ConvertTo-Html -Title "Mon Aide : $env:USERNAME" > c:\ps.html

