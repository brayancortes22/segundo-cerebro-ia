# Script de sincronización automática a GitHub para Segundo Cerebro
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "🔄 Sincronizando Segundo Cerebro con GitHub..." -ForegroundColor Cyan

# Asegurarse de estar en la rama development
git checkout development
git add .
$status = git status --porcelain
if ($status) {
    git commit -m "sync: actualización automática del cerebro ($timestamp)"
    Write-Host "✅ Cambios confirmados en development" -ForegroundColor Green
} else {
    Write-Host "ℹ️ No hay cambios nuevos en development" -ForegroundColor Yellow
}

# Subir a development
git push origin development

# Sincronizar con rama QA
git checkout qa
git merge development --no-edit -m "sync(qa): fusionar desarrollo ($timestamp)"
git push origin qa

# Sincronizar con rama Main / Production
git checkout main
git merge qa --no-edit -m "sync(prod): fusionar qa ($timestamp)"
git push origin main

# Regresar siempre a development para continuar el trabajo
git checkout development
Write-Host "🚀 ¡Sincronización completa con éxito en las 3 ramas (development, qa, main)!" -ForegroundColor Green
