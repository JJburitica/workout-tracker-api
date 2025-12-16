# Task Tracker API

Una API REST simple para rastrear y administrar tareas. Construida con Node.js y Express.

## 📋 Características

- ✅ Crear nuevas tareas
- ✅ Actualizar tareas existentes
- ✅ Eliminar tareas
- ✅ Marcar tareas como en progreso o completadas
- ✅ Listar todas las tareas
- ✅ Filtrar tareas por estado (completadas, no completadas, en progreso)
- ✅ Persistencia en archivo JSON
- ✅ Manejo de errores robusto

## 🚀 Requisitos

- Node.js (v14 o superior)
- npm

## 📦 Instalación

1. Navega al directorio del proyecto:

```bash
cd task-tracker
```

2. Instala las dependencias:

```bash
npm install
```

## ▶️ Uso

### Iniciar el servidor

**Modo producción:**

```bash
npm start
```

**Modo desarrollo (con auto-reload):**

```bash
npm run dev
```

El servidor estará disponible en `http://localhost:3000`

## 📚 Endpoints de la API

### Salud del Servidor

#### Verificar que el servidor está funcionando

```
GET /health
```

**Respuesta:**

```json
{
  "success": true,
  "message": "El servidor Task Tracker está funcionando correctamente",
  "timestamp": "2025-12-16T10:30:00.000Z"
}
```

### Gestión de Tareas

#### Obtener todas las tareas

```
GET /tasks
```

**Respuesta (200 OK):**

```json
{
  "success": true,
  "count": 2,
  "data": [
    {
      "id": "abc123def456",
      "description": "Completar proyecto",
      "status": "in-progress",
      "createdAt": "2025-12-16T10:00:00.000Z",
      "updatedAt": "2025-12-16T10:15:00.000Z"
    },
    {
      "id": "xyz789uvw456",
      "description": "Revisar código",
      "status": "todo",
      "createdAt": "2025-12-16T09:00:00.000Z",
      "updatedAt": "2025-12-16T09:00:00.000Z"
    }
  ]
}
```

---

#### Crear una nueva tarea

```
POST /tasks
Content-Type: application/json

{
  "description": "Completar proyecto"
}
```

**Respuesta (201 Created):**

```json
{
  "success": true,
  "message": "Tarea creada exitosamente",
  "data": {
    "id": "abc123def456",
    "description": "Completar proyecto",
    "status": "todo",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:00:00.000Z"
  }
}
```

---

#### Obtener una tarea específica

```
GET /tasks/:id
```

**Ejemplo:**

```
GET /tasks/abc123def456
```

**Respuesta (200 OK):**

```json
{
  "success": true,
  "data": {
    "id": "abc123def456",
    "description": "Completar proyecto",
    "status": "in-progress",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:15:00.000Z"
  }
}
```

**Respuesta (404 Not Found):**

```json
{
  "success": false,
  "error": "Tarea no encontrada"
}
```

---

#### Actualizar una tarea

```
PUT /tasks/:id
Content-Type: application/json

{
  "description": "Nuevo título (opcional)",
  "status": "in-progress"
}
```

**Ejemplo:**

```
PUT /tasks/abc123def456
Content-Type: application/json

{
  "status": "done"
}
```

**Respuesta (200 OK):**

```json
{
  "success": true,
  "message": "Tarea actualizada exitosamente",
  "data": {
    "id": "abc123def456",
    "description": "Completar proyecto",
    "status": "done",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:30:00.000Z"
  }
}
```

**Estados válidos:** `todo`, `in-progress`, `done`

---

#### Eliminar una tarea

```
DELETE /tasks/:id
```

**Ejemplo:**

```
DELETE /tasks/abc123def456
```

**Respuesta (200 OK):**

```json
{
  "success": true,
  "message": "Tarea eliminada exitosamente",
  "data": {
    "id": "abc123def456",
    "description": "Completar proyecto",
    "status": "done",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:30:00.000Z"
  }
}
```

---

### Filtros por Estado

#### Obtener tareas completadas

```
GET /tasks/status/completed
```

**Respuesta (200 OK):**

```json
{
  "success": true,
  "count": 1,
  "data": [
    {
      "id": "abc123def456",
      "description": "Tarea completada",
      "status": "done",
      "createdAt": "2025-12-16T10:00:00.000Z",
      "updatedAt": "2025-12-16T10:30:00.000Z"
    }
  ]
}
```

---

#### Obtener tareas no completadas

```
GET /tasks/status/incomplete
```

**Respuesta (200 OK):**

```json
{
  "success": true,
  "count": 1,
  "data": [
    {
      "id": "xyz789uvw456",
      "description": "Revisar código",
      "status": "todo",
      "createdAt": "2025-12-16T09:00:00.000Z",
      "updatedAt": "2025-12-16T09:00:00.000Z"
    }
  ]
}
```

---

#### Obtener tareas en progreso

```
GET /tasks/status/in-progress
```

**Respuesta (200 OK):**

```json
{
  "success": true,
  "count": 1,
  "data": [
    {
      "id": "abc123def456",
      "description": "Completar proyecto",
      "status": "in-progress",
      "createdAt": "2025-12-16T10:00:00.000Z",
      "updatedAt": "2025-12-16T10:15:00.000Z"
    }
  ]
}
```

---

#### Obtener tareas por estado específico

```
GET /tasks/status/:status
```

**Ejemplo:**

```
GET /tasks/status/todo
```

**Valores válidos para :status:** `todo`, `in-progress`, `done`

## 📊 Estructura de Tareas

Cada tarea tiene las siguientes propiedades:

| Propiedad     | Tipo     | Descripción                                  |
| ------------- | -------- | -------------------------------------------- |
| `id`          | string   | Identificador único generado automáticamente |
| `description` | string   | Descripción de la tarea                      |
| `status`      | string   | Estado: `todo`, `in-progress`, `done`        |
| `createdAt`   | ISO 8601 | Fecha y hora de creación                     |
| `updatedAt`   | ISO 8601 | Fecha y hora de última actualización         |

## 💾 Almacenamiento

Las tareas se almacenan en un archivo `tasks.json` en la raíz del proyecto:

```json
[
  {
    "id": "abc123def456",
    "description": "Completar proyecto",
    "status": "in-progress",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:15:00.000Z"
  }
]
```

El archivo se crea automáticamente en el primer acceso.

## 🛠️ Tecnologías Utilizadas

- **Node.js**: Runtime de JavaScript
- **Express**: Framework web minimalista
- **File System (fs)**: Módulo nativo para manejo de archivos
- **Nodemon**: Herramienta de desarrollo para auto-reload (devDependency)

## 📝 Ejemplos de Uso

### Usando cURL

**Crear una tarea:**

```bash
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d '{"description": "Aprender Node.js"}'
```

**Obtener todas las tareas:**

```bash
curl http://localhost:3000/tasks
```

**Actualizar una tarea:**

```bash
curl -X PUT http://localhost:3000/tasks/abc123def456 \
  -H "Content-Type: application/json" \
  -d '{"status": "in-progress"}'
```

**Eliminar una tarea:**

```bash
curl -X DELETE http://localhost:3000/tasks/abc123def456
```

**Obtener tareas completadas:**

```bash
curl http://localhost:3000/tasks/status/completed
```

### Usando JavaScript/Fetch API

```javascript
// Crear una tarea
async function createTask(description) {
  const response = await fetch("http://localhost:3000/tasks", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ description }),
  });
  return response.json();
}

// Obtener todas las tareas
async function getAllTasks() {
  const response = await fetch("http://localhost:3000/tasks");
  return response.json();
}

// Actualizar una tarea
async function updateTask(id, updates) {
  const response = await fetch(`http://localhost:3000/tasks/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(updates),
  });
  return response.json();
}

// Eliminar una tarea
async function deleteTask(id) {
  const response = await fetch(`http://localhost:3000/tasks/${id}`, {
    method: "DELETE",
  });
  return response.json();
}
```

## ✅ Validaciones

- La descripción de la tarea es requerida y no puede estar vacía
- El estado debe ser uno de: `todo`, `in-progress`, `done`
- Al actualizar, al menos un campo debe proporcionarse
- El ID de la tarea es único y generado automáticamente

## 🐛 Manejo de Errores

La API devuelve respuestas apropiadas para todos los casos:

| Status | Caso                                     |
| ------ | ---------------------------------------- |
| 200    | Operación exitosa (GET, PUT, DELETE)     |
| 201    | Recurso creado (POST)                    |
| 400    | Solicitud inválida (error de validación) |
| 404    | Recurso no encontrado                    |
| 500    | Error interno del servidor               |

## 📄 Licencia

ISC

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para cambios mayores, abre un issue primero.
