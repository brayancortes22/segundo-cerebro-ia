[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$DestinationRoot = (Join-Path $env:USERPROFILE '.gemini\config')
)

$vaultRoot = Split-Path -Parent $PSScriptRoot
$sourceSkills = Join-Path $vaultRoot '.agents\skills'
$sourceRule = Join-Path $vaultRoot '.agents\rules\skills-autoselection.md'
$destinationSkills = Join-Path $DestinationRoot 'skills'
$destinationRules = Join-Path $DestinationRoot 'rules'

if (-not (Test-Path -LiteralPath $sourceSkills -PathType Container)) {
    throw "No se encontró el catálogo de skills: $sourceSkills"
}
if (-not (Test-Path -LiteralPath $sourceRule -PathType Leaf)) {
    throw "No se encontró la regla de selección automática: $sourceRule"
}

$skillFolders = @(Get-ChildItem -LiteralPath $sourceSkills -Directory)
if ($skillFolders.Count -eq 0) {
    throw "El catálogo no contiene carpetas de skills: $sourceSkills"
}
foreach ($folder in $skillFolders) {
    if (-not (Test-Path -LiteralPath (Join-Path $folder.FullName 'SKILL.md') -PathType Leaf)) {
        throw "Falta SKILL.md en la carpeta: $($folder.FullName)"
    }
}

foreach ($destination in @($destinationSkills, $destinationRules)) {
    if (-not (Test-Path -LiteralPath $destination -PathType Container)) {
        if ($PSCmdlet.ShouldProcess($destination, 'Crear directorio global de Antigravity')) {
            New-Item -ItemType Directory -Path $destination -Force | Out-Null
        }
    }
}

foreach ($folder in $skillFolders) {
    if ($PSCmdlet.ShouldProcess((Join-Path $destinationSkills $folder.Name), 'Copiar o actualizar skill')) {
        Copy-Item -LiteralPath $folder.FullName -Destination $destinationSkills -Recurse -Force
    }
}

if ($PSCmdlet.ShouldProcess((Join-Path $destinationRules 'skills-autoselection.md'), 'Copiar o actualizar regla global')) {
    Copy-Item -LiteralPath $sourceRule -Destination (Join-Path $destinationRules 'skills-autoselection.md') -Force
}

Write-Output "Skills procesadas: $($skillFolders.Count). Reglas procesadas: 1."
Write-Output 'La sincronización sobrescribe archivos con el mismo nombre, conserva otros archivos y no elimina recursos globales.'
