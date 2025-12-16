# Estructura del Proyecto Task Tracker API

```
task-tracker/
├── src/
│   ├── index.js              # Servidor Express principal
│   └── taskManager.js        # Módulo de gestión de tareas
├── package.json              # Configuración del proyecto y dependencias
├── .gitignore               # Archivos ignorados por git
├── README.md                # Documentación principal
├── STRUCTURE.md             # Este archivo
├── test-examples.bat        # Ejemplos de prueba (Windows CMD)
├── test-examples.ps1        # Ejemplos de prueba (PowerShell)
└── tasks.json              # Archivo de datos (generado automáticamente)
```

## 📁 Descripción de Archivos

### `src/index.js`

Servidor Express principal que contiene:

- Configuración de middlewares (Express JSON)
- Todos los endpoints REST
- Manejo de errores
- Inicialización del servidor

**Endpoints implementados:**

- `GET /health` - Verificar salud del servidor
- `GET /tasks` - Obtener todas las tareas
- `POST /tasks` - Crear nueva tarea
- `GET /tasks/:id` - Obtener tarea específica
- `PUT /tasks/:id` - Actualizar tarea
- `DELETE /tasks/:id` - Eliminar tarea
- `GET /tasks/status/completed` - Tareas completadas
- `GET /tasks/status/incomplete` - Tareas no completadas
- `GET /tasks/status/in-progress` - Tareas en progreso
- `GET /tasks/status/:status` - Tareas por estado genérico

### `src/taskManager.js`

Módulo de lógica de negocio para gestión de tareas:

- `initializeTasks()` - Inicializar archivo JSON
- `getAllTasks()` - Leer todas las tareas
- `createTask(description)` - Crear nueva tarea
- `getTaskById(id)` - Obtener tarea por ID
- `updateTask(id, updates)` - Actualizar tarea
- `deleteTask(id)` - Eliminar tarea
- `getTasksByStatus(status)` - Filtrar por estado
- `getCompletedTasks()` - Obtener completadas
- `getIncompleteTasks()` - Obtener no completadas
- `getInProgressTasks()` - Obtener en progreso
- `saveTasks(tasks)` - Guardar tareas a archivo

### `package.json`

Configuración del proyecto con:

- **Dependencias:**
  - `express@^4.18.2` - Framework web
- **DevDependencies:**

  - `nodemon@^3.0.1` - Auto-reload en desarrollo

- **Scripts:**
  - `npm start` - Ejecutar en producción
  - `npm run dev` - Ejecutar en desarrollo con nodemon

### `tasks.json`

Archivo de persistencia de datos (generado automáticamente):

```json
[
  {
    "id": "abc123",
    "description": "Tarea ejemplo",
    "status": "todo",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:00:00.000Z"
  }
]
```

### `.gitignore`

Archivos que git ignorará:

- `node_modules/` - Dependencias instaladas
- `tasks.json` - Datos de tareas
- `.env` - Variables de entorno
- Logs y archivos temporales

### `README.md`

Documentación completa del proyecto con:

- Descripción general
- Instrucciones de instalación
- Guía de uso
- Documentación de endpoints
- Ejemplos de uso con cURL y Fetch API

### `test-examples.bat`

Script de prueba para Windows (CMD) con ejemplos de cURL

### `test-examples.ps1`

Script de prueba para PowerShell con ejemplos automatizados

## 🚀 Flujo de Uso

1. **Instalar dependencias:**

   ```bash
   npm install
   ```

2. **Iniciar servidor:**

   ```bash
   npm start
   ```

3. **Pruebas:**
   - Windows CMD: `test-examples.bat`
   - PowerShell: `.\test-examples.ps1`
   - cURL manualmente
   - Cliente REST (Postman, Insomnia, etc.)

## 📊 Flujo de Datos

```
Cliente HTTP
    ↓
Express Router (index.js)
    ↓
Validación de Request
    ↓
Task Manager (taskManager.js)
    ↓
File System (tasks.json)
    ↓
Respuesta JSON
```

## 🔄 Ciclo de vida de una tarea

1. **Creación:** `POST /tasks` → Tarea creada con estado `todo`
2. **Actualización:** `PUT /tasks/:id` → Cambiar estado o descripción
3. **Consulta:** `GET /tasks` o `/tasks/:id` → Obtener información
4. **Eliminación:** `DELETE /tasks/:id` → Remover permanentemente

## 📝 Estados de tareas

- **`todo`**: Tarea pendiente (por hacer)
- **`in-progress`**: Tarea en desarrollo
- **`done`**: Tarea completada

## 🔐 Validaciones

- Descripción no puede estar vacía
- Estados solo pueden ser: `todo`, `in-progress`, `done`
- ID es único y generado automáticamente
- Timestamps se generan y actualizan automáticamente

## 📡 Códigos HTTP

- `200`: OK - Operación exitosa
- `201`: Created - Recurso creado
- `400`: Bad Request - Solicitud inválida
- `404`: Not Found - Recurso no encontrado
- `500`: Internal Server Error - Error del servidor
