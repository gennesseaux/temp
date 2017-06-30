cls

# Taille du mot de passe
$PassworldLength = 8;

# Liste des caractères autorisés
$Character_LowerCase = "abcdefghiklmnprstuvwxyz";
$Character_UpperCase = "ABCDEFGHKLMNPRSTUVWXYZ";
$Character_Numbers = "0123456789";
$Character_SpecialChars = "$%&/()=?+*#[]{}-_@";
$Characters = $Character_LowerCase + $Character_UpperCase + $Character_Numbers + $Character_SpecialChars;

# Création du mot de passe
$Password = [String]::Empty

# Au minimum 1 caratère minuscule
$Password += $Character_LowerCase[$(Get-Random -Minimum 0 -Maximum $Character_LowerCase.Length)]

# Au minimum 1 caratères majuscule
$Password += $Character_UpperCase[$(Get-Random -Minimum 0 -Maximum $Character_UpperCase.Length)]

# Au minimum 1 nombre
$Password += $Character_Numbers[$(Get-Random -Minimum 0 -Maximum $Character_Numbers.Length)]

# Au minimum 1 caractère spéciale
$Password += $Character_SpecialChars[$(Get-Random -Minimum 0 -Maximum $Character_SpecialChars.Length)]


for($i = $Password.Length; $i -lt $PassworldLength; $i++)
{
    $RandomNumber = Get-Random -Minimum 0 -Maximum $Characters.Length
    $Password += $Characters[$RandomNumber]
}

$Password