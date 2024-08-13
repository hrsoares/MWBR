# Verificar versão instalada do Edge
$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (Test-Path $edgePath) {
    $edgeVersion = (Get-Item $edgePath).VersionInfo.ProductVersion
} else {
    $edgeVersion = "Não instalado"
}

# Verificar versão instalada do Chrome
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
if (Test-Path $chromePath) {
    $chromeVersion = (Get-Item $chromePath).VersionInfo.ProductVersion
} else {
    $chromeVersion = "Não instalado"
}

# Output do status de descoberta
$discoveryStatus = @{
    EdgeInstalledVersion = $edgeVersion
    ChromeInstalledVersion = $chromeVersion
}

# Retornar status como JSON
$discoveryStatus | ConvertTo-Json -Compress
