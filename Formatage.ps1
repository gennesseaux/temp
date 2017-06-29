

$nom = "GENNESSEAUX";
$prenom = "Jocelyn";
$date = Get-Date;

$message = $("Mon nom est '{0} {1}', il est {2:hh:mm}" -f $nom,$prenom,$date);

Write-Host $messagemessage