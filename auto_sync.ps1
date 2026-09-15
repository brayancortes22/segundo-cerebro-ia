# Script de sincronización automática a GitHub para Segundo Cerebro
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "Sincronizando Segundo Cerebro con GitHub..." -ForegroundColor Cyan

# 1. Rama development
git checkout development
git add .
$status = git status --porcelain
if ($status) {
    git commit -m "sync: actualizacion automatica del cerebro ($timestamp)"
    Write-Host "Cambios confirmados en development" -ForegroundColor Green
} else {
    Write-Host "No hay cambios nuevos en development" -ForegroundColor Yellow
}
git push origin development

# 2. Rama qa
git checkout qa
git merge development --no-edit -m "sync(qa): fusionar desarrollo ($timestamp)"
git push origin qa

# 3. Rama main
git checkout main
git merge qa --no-edit -m "sync(main): fusionar qa ($timestamp)"
git push origin main

# Regresar a development
git checkout development
Write-Host "Sincronizacion completada con exito en las 3 ramas: development, qa, main" -ForegroundColor Green
