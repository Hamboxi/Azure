# Define os parâmetros
$resourceGroupName = "dev-geral"
$deploymentName = "vscodedeploy"
$templateFilePath = "vmbyimage.json"
$nameNetwork = "vscodenet"
$parameters = @{
    vmName = "vscode";
    location = "Canada Central";
    vmSize = "Standard_F2s_v2";
    maxPriceP = "0.03";
    <# dataDisks = @(
        @{
            lun = 0;
            createOption = "Attach";
            caching = "Read";
            diskSizeGB = 4;
            managedDisk = 
            @{
                id = "/subscriptions/31fad7a5-8666-4bfd-8b77-efae9758905b/resourceGroups/dev-geral/providers/Microsoft.Compute/disks/vscode_data01";
                storageAccountType = "Standard_LRS"
            };
            deleteOption = "Delete";
            writeAcceleratorEnabled = $false
        } #>
    #)
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