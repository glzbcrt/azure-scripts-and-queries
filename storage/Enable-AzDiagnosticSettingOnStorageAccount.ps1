<#
    .SYNOPSIS
    Create a dianogstic setting on any Azure Storage Account to send all blob and file logs to a Azure Log Analytics Workspace.

    .PARAMETER $ResourceId
    Resource id of the storage account where the diagnostic settings should be created.

    .PARAMETER $WorkspaceId
    Resource id of the Log Analytics Workspace where the logs will be pushed.

    .PARAMETER $DiagnosticSettingName
    Diagnostic setting name. Default is "logs".
#>
param(
    [Parameter(Mandatory = $True)]
    [string]$ResourceId,

    [Parameter(Mandatory = $True)]
    [string]$WorkspaceId,

    [string]$DiagnosticSettingName = "logs"
)

$log = @()
$log += New-AzDiagnosticSettingLogSettingsObject -Enabled $true -CategoryGroup allLogs
$log += New-AzDiagnosticSettingLogSettingsObject -Enabled $true -CategoryGroup audit

New-AzDiagnosticSetting -Name $DiagnosticSettingName -ResourceId "$ResourceId/blobServices/default" -WorkspaceId $WorkspaceId -Log $log
New-AzDiagnosticSetting -Name $DiagnosticSettingName -ResourceId "$ResourceId/fileServices/default" -WorkspaceId $WorkspaceId -Log $log
