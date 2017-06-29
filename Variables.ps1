
# Création d'une variable non typé
$v = 1
$v = "2"

# Typage d'une variable
[int]$i5 = 5
# $i5="a" -> Erreur

# Création d'une constante
Set-Variable -Name MY_CONST -Value "Une valeur" -Option Constant
Write-Host $MY_CONST

# création d'un tableau
$t1 = 1,2,3,4
$t2 = 1..4
$t3 = [int]5, [double]2.5, [char]'A'
$t4 = @(1,2,3)

$t = @() # crée un tableau vide
[int[]]$t = @() # crée un tableau d'entier

$t = 1..20
$t = $t[0..2]+$t[12..20]
$t

[System.Array].GetMembers() | select Name