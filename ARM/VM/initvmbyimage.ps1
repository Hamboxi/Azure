# Define os parâmetros
$resourceGroupName = "dev-geral"
$deploymentName = "vscodedeploy"
$templateFilePath = "vmbyimage.json"
$nameNetwork = "vscodenet"
$parameters = @{
    "vmName" = "vscode";
    "location" = "Canada Central";
    "vmSize" = "Standard_F2s_v2"; #(Standard_F2s_v2, Standard_F4s_v2 ou Standard_D2as_v4)
    "maxPriceP" = "0.03"
}

# Verifica se já está conectado a uma conta do Azure
$context = Get-AzContext

if (-not $context) {
    # Conecta à sua conta do Azure
    Connect-AzAccount
}

# Seleciona a assinatura correta
Select-AzSubscription -SubscriptionName "Azure for Students"

# Implanta o modelo
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $templateFilePath `
    -TemplateParameterObject $parameters `
    -nameNetworkProfile $nameNetwork