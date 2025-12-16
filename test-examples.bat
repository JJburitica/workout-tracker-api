@echo off
REM Ejemplos de prueba de la API Task Tracker
REM Este archivo contiene ejemplos de cómo probar los endpoints usando cURL

echo.
echo ====================================
echo Task Tracker API - Ejemplos de cURL
echo ====================================
echo.

REM Verificar que el servidor está funcionando
echo [1] Verificar salud del servidor
curl http://localhost:3000/health
echo.
echo.

REM Obtener todas las tareas (inicialmente vacío)
echo [2] Obtener todas las tareas
curl http://localhost:3000/tasks
echo.
echo.

REM Crear primera tarea
echo [3] Crear primera tarea: "Aprender Node.js"
curl -X POST http://localhost:3000/tasks ^
  -H "Content-Type: application/json" ^
  -d "{\"description\": \"Aprender Node.js\"}"
echo.
echo.

REM Crear segunda tarea
echo [4] Crear segunda tarea: "Completar proyecto API"
curl -X POST http://localhost:3000/tasks ^
  -H "Content-Type: application/json" ^
  -d "{\"description\": \"Completar proyecto API\"}"
echo.
echo.

REM Crear tercera tarea
echo [5] Crear tercera tarea: "Revisar documentación"
curl -X POST http://localhost:3000/tasks ^
  -H "Content-Type: application/json" ^
  -d "{\"description\": \"Revisar documentación\"}"
echo.
echo.

REM Obtener todas las tareas nuevamente
echo [6] Obtener todas las tareas (ahora con datos)
curl http://localhost:3000/tasks
echo.
echo.

REM Obtener tareas no completadas
echo [7] Obtener tareas no completadas
curl http://localhost:3000/tasks/status/incomplete
echo.
echo.

REM NOTA: Necesitas cambiar el ID en los siguientes comandos con IDs reales

echo [NOTA] Los siguientes comandos necesitan IDs reales. Reemplaza "TASK_ID" con un ID real
echo.

REM Obtener una tarea específica
echo [8] Obtener una tarea específica
echo   Comando: curl http://localhost:3000/tasks/TASK_ID
echo.

REM Actualizar estado a "in-progress"
echo [9] Actualizar tarea a "in-progress"
echo   Comando: curl -X PUT http://localhost:3000/tasks/TASK_ID ^
echo     -H "Content-Type: application/json" ^
echo     -d "{\"status\": \"in-progress\"}"
echo.

REM Actualizar descripción
echo [10] Actualizar descripción de tarea
echo   Comando: curl -X PUT http://localhost:3000/tasks/TASK_ID ^
echo     -H "Content-Type: application/json" ^
echo     -d "{\"description\": \"Nueva descripción\"}"
echo.

REM Marcar como completada
echo [11] Marcar tarea como completada
echo   Comando: curl -X PUT http://localhost:3000/tasks/TASK_ID ^
echo     -H "Content-Type: application/json" ^
echo     -d "{\"status\": \"done\"}"
echo.

REM Obtener tareas completadas
echo [12] Obtener tareas completadas
curl http://localhost:3000/tasks/status/completed
echo.
echo.

REM Obtener tareas en progreso
echo [13] Obtener tareas en progreso
curl http://localhost:3000/tasks/status/in-progress
echo.
echo.

REM Eliminar una tarea
echo [14] Eliminar una tarea
echo   Comando: curl -X DELETE http://localhost:3000/tasks/TASK_ID
echo.

REM Obtener tareas por estado específico
echo [15] Obtener tareas por estado específico
echo   Comando: curl http://localhost:3000/tasks/status/ESTADO
echo   ESTADO puede ser: todo, in-progress, done
echo.

echo ====================================
echo Fin de ejemplos
echo ====================================
pause
