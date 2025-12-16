# Casos de Prueba - Task Tracker API

Este documento describe los casos de prueba para validar que la API funciona correctamente.

## 🧪 Casos de Prueba

### 1. Verificar Salud del Servidor

**Descripción:** Validar que el servidor está funcionando.

**Endpoint:** `GET /health`

**Paso a paso:**

```bash
curl http://localhost:3000/health
```

**Resultado esperado:**

- Status Code: 200
- Response:

```json
{
  "success": true,
  "message": "El servidor Task Tracker está funcionando correctamente",
  "timestamp": "2025-12-16T10:30:00.000Z"
}
```

---

### 2. Crear Primera Tarea

**Descripción:** Crear una nueva tarea con descripción.

**Endpoint:** `POST /tasks`

**Body:**

```json
{
  "description": "Aprender Node.js"
}
```

**Paso a paso:**

```bash
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d "{\"description\": \"Aprender Node.js\"}"
```

**Resultado esperado:**

- Status Code: 201
- Response contiene:
  - `success: true`
  - `data.id` (guardarlo para pruebas posteriores)
  - `data.status: "todo"`
  - `data.createdAt` y `data.updatedAt`

---

### 3. Crear Segunda Tarea

**Descripción:** Crear otra tarea.

**Endpoint:** `POST /tasks`

**Body:**

```json
{
  "description": "Completar proyecto API"
}
```

---

### 4. Obtener Todas las Tareas

**Descripción:** Listar todas las tareas creadas.

**Endpoint:** `GET /tasks`

**Paso a paso:**

```bash
curl http://localhost:3000/tasks
```

**Resultado esperado:**

- Status Code: 200
- Response contiene:
  - `count: 2` (las dos tareas creadas)
  - Array `data` con ambas tareas

---

### 5. Obtener Tarea Específica

**Descripción:** Obtener una tarea por su ID.

**Endpoint:** `GET /tasks/:id`

**Paso a paso (reemplaza TASK_ID):**

```bash
curl http://localhost:3000/tasks/TASK_ID
```

**Resultado esperado:**

- Status Code: 200
- Response contiene la tarea especificada

---

### 6. Actualizar Estado a "in-progress"

**Descripción:** Cambiar el estado de una tarea a "in-progress".

**Endpoint:** `PUT /tasks/:id`

**Body:**

```json
{
  "status": "in-progress"
}
```

**Paso a paso:**

```bash
curl -X PUT http://localhost:3000/tasks/TASK_ID \
  -H "Content-Type: application/json" \
  -d "{\"status\": \"in-progress\"}"
```

**Resultado esperado:**

- Status Code: 200
- Response:
  - `data.status: "in-progress"`
  - `data.updatedAt` actualizado

---

### 7. Actualizar Descripción

**Descripción:** Cambiar la descripción de una tarea.

**Endpoint:** `PUT /tasks/:id`

**Body:**

```json
{
  "description": "Nueva descripción de tarea"
}
```

---

### 8. Obtener Tareas en Progreso

**Descripción:** Filtrar tareas con estado "in-progress".

**Endpoint:** `GET /tasks/status/in-progress`

**Paso a paso:**

```bash
curl http://localhost:3000/tasks/status/in-progress
```

**Resultado esperado:**

- Status Code: 200
- Response contiene solo tareas con `status: "in-progress"`

---

### 9. Marcar Tarea como Completada

**Descripción:** Cambiar estado a "done".

**Endpoint:** `PUT /tasks/:id`

**Body:**

```json
{
  "status": "done"
}
```

---

### 10. Obtener Tareas Completadas

**Descripción:** Filtrar tareas completadas.

**Endpoint:** `GET /tasks/status/completed`

**Paso a paso:**

```bash
curl http://localhost:3000/tasks/status/completed
```

**Resultado esperado:**

- Status Code: 200
- Response contiene tareas con `status: "done"`

---

### 11. Obtener Tareas No Completadas

**Descripción:** Filtrar tareas no completadas.

**Endpoint:** `GET /tasks/status/incomplete`

**Paso a paso:**

```bash
curl http://localhost:3000/tasks/status/incomplete
```

**Resultado esperado:**

- Status Code: 200
- Response contiene tareas donde `status != "done"`

---

### 12. Eliminar una Tarea

**Descripción:** Eliminar una tarea específica.

**Endpoint:** `DELETE /tasks/:id`

**Paso a paso:**

```bash
curl -X DELETE http://localhost:3000/tasks/TASK_ID
```

**Resultado esperado:**

- Status Code: 200
- Response:
  - `success: true`
  - `data` contiene la tarea eliminada

---

### 13. Verificar Tarea Eliminada

**Descripción:** Intentar obtener una tarea que fue eliminada.

**Endpoint:** `GET /tasks/:id` (con ID eliminado)

**Resultado esperado:**

- Status Code: 404
- Response:

```json
{
  "success": false,
  "error": "Tarea no encontrada"
}
```

---

## ❌ Casos de Error

### 1. Crear Tarea sin Descripción

**Endpoint:** `POST /tasks`

**Body:**

```json
{
  "description": ""
}
```

**Resultado esperado:**

- Status Code: 400
- Error: "La descripción es requerida"

---

### 2. Actualizar con Estado Inválido

**Endpoint:** `PUT /tasks/:id`

**Body:**

```json
{
  "status": "invalid_status"
}
```

**Resultado esperado:**

- Status Code: 400
- Error: "Estado inválido. Debe ser: todo, in-progress o done"

---

### 3. Obtener Tarea Inexistente

**Endpoint:** `GET /tasks/invalid_id`

**Resultado esperado:**

- Status Code: 404
- Error: "Tarea no encontrada"

---

### 4. Eliminar Tarea Inexistente

**Endpoint:** `DELETE /tasks/invalid_id`

**Resultado esperado:**

- Status Code: 404
- Error: "Tarea no encontrada"

---

### 5. Acceder a Ruta No Existente

**Endpoint:** `GET /invalid-route`

**Resultado esperado:**

- Status Code: 404
- Error: "Ruta no encontrada"

---

## ✅ Checklist de Validación

- [ ] Servidor inicia correctamente en puerto 3000
- [ ] Endpoint `/health` retorna 200
- [ ] Crear tareas retorna 201 con datos completos
- [ ] Obtener todas las tareas retorna array correcto
- [ ] Obtener tarea por ID funciona
- [ ] Actualizar estado funciona
- [ ] Actualizar descripción funciona
- [ ] Filtro de tareas completadas funciona
- [ ] Filtro de tareas incompletas funciona
- [ ] Filtro de tareas en progreso funciona
- [ ] Eliminar tareas funciona
- [ ] Tarea eliminada no aparece en lista
- [ ] Errores retornan status codes correctos
- [ ] Archivo tasks.json se crea automáticamente
- [ ] Archivo tasks.json persiste los datos

---

## 🔧 Herramientas de Prueba Recomendadas

1. **cURL** - Línea de comandos
2. **Postman** - GUI con colecciones
3. **Insomnia** - Cliente REST ligero
4. **REST Client (VS Code)** - Plugin en VS Code
5. **Thunder Client** - Plugin en VS Code

---

## 📊 Datos de Prueba de Ejemplo

```json
[
  {
    "id": "abc123def456",
    "description": "Aprender Node.js",
    "status": "in-progress",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:15:00.000Z"
  },
  {
    "id": "xyz789uvw456",
    "description": "Completar proyecto API",
    "status": "done",
    "createdAt": "2025-12-16T09:00:00.000Z",
    "updatedAt": "2025-12-16T10:30:00.000Z"
  },
  {
    "id": "pqr321mno456",
    "description": "Revisar documentación",
    "status": "todo",
    "createdAt": "2025-12-16T08:00:00.000Z",
    "updatedAt": "2025-12-16T08:00:00.000Z"
  }
]
```
