# Ejemplos de prueba de la API Task Tracker
# Este archivo contiene ejemplos de cómo probar los endpoints usando PowerShell

function Test-TaskTrackerAPI {
    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host "Task Tracker API - Ejemplos en PowerShell" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host ""

    $baseURL = "http://localhost:3000"

    # [1] Verificar salud del servidor
    Write-Host "[1] Verificar salud del servidor" -ForegroundColor Green
    try {
        $response = Invoke-RestMethod -Uri "$baseURL/health" -Method Get
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [2] Obtener todas las tareas
    Write-Host "[2] Obtener todas las tareas" -ForegroundColor Green
    try {
        $response = Invoke-RestMethod -Uri "$baseURL/tasks" -Method Get
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [3] Crear primera tarea
    Write-Host "[3] Crear primera tarea: 'Aprender Node.js'" -ForegroundColor Green
    try {
        $body = @{
            description = "Aprender Node.js"
        } | ConvertTo-Json

        $response = Invoke-RestMethod -Uri "$baseURL/tasks" `
            -Method Post `
            -Body $body `
            -ContentType "application/json"
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
        $taskId1 = $response.data.id
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [4] Crear segunda tarea
    Write-Host "[4] Crear segunda tarea: 'Completar proyecto API'" -ForegroundColor Green
    try {
        $body = @{
            description = "Completar proyecto API"
        } | ConvertTo-Json

        $response = Invoke-RestMethod -Uri "$baseURL/tasks" `
            -Method Post `
            -Body $body `
            -ContentType "application/json"
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
        $taskId2 = $response.data.id
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [5] Crear tercera tarea
    Write-Host "[5] Crear tercera tarea: 'Revisar documentación'" -ForegroundColor Green
    try {
        $body = @{
            description = "Revisar documentación"
        } | ConvertTo-Json

        $response = Invoke-RestMethod -Uri "$baseURL/tasks" `
            -Method Post `
            -Body $body `
            -ContentType "application/json"
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
        $taskId3 = $response.data.id
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [6] Obtener todas las tareas nuevamente
    Write-Host "[6] Obtener todas las tareas (ahora con datos)" -ForegroundColor Green
    try {
        $response = Invoke-RestMethod -Uri "$baseURL/tasks" -Method Get
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [7] Obtener tareas no completadas
    Write-Host "[7] Obtener tareas no completadas" -ForegroundColor Green
    try {
        $response = Invoke-RestMethod -Uri "$baseURL/tasks/status/incomplete" -Method Get
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [8] Obtener una tarea específica
    Write-Host "[8] Obtener una tarea específica (primera tarea creada)" -ForegroundColor Green
    if ($taskId1) {
        try {
            $response = Invoke-RestMethod -Uri "$baseURL/tasks/$taskId1" -Method Get
            Write-Host ($response | ConvertTo-Json) -ForegroundColor White
        }
        catch {
            Write-Host "Error: $_" -ForegroundColor Red
        }
    }
    Write-Host ""

    # [9] Actualizar estado a "in-progress"
    Write-Host "[9] Actualizar tarea a 'in-progress'" -ForegroundColor Green
    if ($taskId1) {
        try {
            $body = @{
                status = "in-progress"
            } | ConvertTo-Json

            $response = Invoke-RestMethod -Uri "$baseURL/tasks/$taskId1" `
                -Method Put `
                -Body $body `
                -ContentType "application/json"
            Write-Host ($response | ConvertTo-Json) -ForegroundColor White
        }
        catch {
            Write-Host "Error: $_" -ForegroundColor Red
        }
    }
    Write-Host ""

    # [10] Obtener tareas en progreso
    Write-Host "[10] Obtener tareas en progreso" -ForegroundColor Green
    try {
        $response = Invoke-RestMethod -Uri "$baseURL/tasks/status/in-progress" -Method Get
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [11] Marcar tarea como completada
    Write-Host "[11] Marcar tarea como completada" -ForegroundColor Green
    if ($taskId2) {
        try {
            $body = @{
                status = "done"
            } | ConvertTo-Json

            $response = Invoke-RestMethod -Uri "$baseURL/tasks/$taskId2" `
                -Method Put `
                -Body $body `
                -ContentType "application/json"
            Write-Host ($response | ConvertTo-Json) -ForegroundColor White
        }
        catch {
            Write-Host "Error: $_" -ForegroundColor Red
        }
    }
    Write-Host ""

    # [12] Obtener tareas completadas
    Write-Host "[12] Obtener tareas completadas" -ForegroundColor Green
    try {
        $response = Invoke-RestMethod -Uri "$baseURL/tasks/status/completed" -Method Get
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    # [13] Actualizar descripción de tarea
    Write-Host "[13] Actualizar descripción de tarea" -ForegroundColor Green
    if ($taskId3) {
        try {
            $body = @{
                description = "Revisar documentación completa del proyecto"
            } | ConvertTo-Json

            $response = Invoke-RestMethod -Uri "$baseURL/tasks/$taskId3" `
                -Method Put `
                -Body $body `
                -ContentType "application/json"
            Write-Host ($response | ConvertTo-Json) -ForegroundColor White
        }
        catch {
            Write-Host "Error: $_" -ForegroundColor Red
        }
    }
    Write-Host ""

    # [14] Eliminar una tarea
    Write-Host "[14] Eliminar una tarea" -ForegroundColor Green
    if ($taskId3) {
        try {
            $response = Invoke-RestMethod -Uri "$baseURL/tasks/$taskId3" `
                -Method Delete
            Write-Host ($response | ConvertTo-Json) -ForegroundColor White
        }
        catch {
            Write-Host "Error: $_" -ForegroundColor Red
        }
    }
    Write-Host ""

    # [15] Obtener todas las tareas finales
    Write-Host "[15] Obtener todas las tareas (después de eliminar una)" -ForegroundColor Green
    try {
        $response = Invoke-RestMethod -Uri "$baseURL/tasks" -Method Get
        Write-Host ($response | ConvertTo-Json) -ForegroundColor White
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    Write-Host ""

    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host "Fin de ejemplos" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor Cyan
}

# Ejecutar las pruebas
Test-TaskTrackerAPI
