# Script para verificar e instalar os módulos necessários, além de verificar e instalar o principal de serviço para o Microsoft.Azure.SyncFabric.

# Função para verificar se um módulo está instalado
function Check-Module {
    param (
        [string]$ModuleName
    )
    if (-not (Get-Module -ListAvailable -Name $ModuleName)) {
        Write-Host "Módulo $ModuleName não encontrado. Instalando..." -ForegroundColor Yellow
        Install-Module -Name $ModuleName -Force -AllowClobber
    } else {
        Write-Host "Módulo $ModuleName já está instalado." -ForegroundColor Green
    }
}

# Verificar e instalar os módulos necessários
$modules = @("AzureAD")
foreach ($module in $modules) {
    Check-Module -ModuleName $module
}

# Importar os módulos
Import-Module AzureAD

# Autenticar no Azure
Write-Host "Autenticando no Azure..." -ForegroundColor Cyan
Connect-AzureAD

# Verificar se o Service Principal já existe no tenant
$ServicePrincipalAppId = "00000014-0000-0000-c000-000000000000"
$ServicePrincipal = Get-AzureADServicePrincipal -Filter "AppId eq '$ServicePrincipalAppId'"

if ($ServicePrincipal) {
    Write-Host "O Service Principal para Microsoft.Azure.SyncFabric já existe no tenant." -ForegroundColor Green
} else {
    Write-Host "O Service Principal para Microsoft.Azure.SyncFabric NÃO existe no tenant. Criando o Service Principal..." -ForegroundColor Yellow
    
    try {
        $ServicePrincipal = New-AzureADServicePrincipal -AppId $ServicePrincipalAppId
        Write-Host "O Service Principal para Microsoft.Azure.SyncFabric foi criado com sucesso." -ForegroundColor Green
    } catch {
        Write-Host "Erro ao criar o Service Principal: $_" -ForegroundColor Red
    }
}
