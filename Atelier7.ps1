

#
[int]$running = 0
[int]$stopped = 0
[int]$undef = 0

foreach($service in Get-Service) {

    if($service.Status -eq 'Running') {
        $running++
        Write-Host $service.DisplayName -ForegroundColor Green
    }
    elseif ($service.Status -eq 'Stopped') {
        $stopped++
        Write-Host $service.DisplayName -ForegroundColor Red
    }
    else {
        $undef++
    }
}

Write-Host
Write-Host "Demarré : " $running
Write-Host "Arrêté : " $stopped
Write-Host "Non défini : " $undef
Write-Host
