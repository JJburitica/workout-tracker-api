# 🚀 Guía Rápida - Task Tracker API

## ⚡ Inicio Rápido en 3 pasos

### Paso 1: Instalar dependencias

```bash
npm install
```

Esto instalará Express y sus dependencias necesarias.

### Paso 2: Iniciar el servidor

```bash
npm start
```

El servidor se iniciará en `http://localhost:3000`

### Paso 3: Probar la API

Abre otra terminal y ejecuta:

**PowerShell:**

```powershell
.\test-examples.ps1
```

**CMD:**

```cmd
test-examples.bat
```

**O manualmente con cURL:**

```bash
# Verificar que el servidor está funcionando
curl http://localhost:3000/health

# Crear una tarea
curl -X POST http://localhost:3000/tasks ^
  -H "Content-Type: application/json" ^
  -d "{\"description\": \"Mi primera tarea\"}"

# Obtener todas las tareas
curl http://localhost:3000/tasks
```

---

## 📚 Endpoints Principales

| Método | Endpoint                    | Descripción                   |
| ------ | --------------------------- | ----------------------------- |
| GET    | `/health`                   | Verificar estado del servidor |
| GET    | `/tasks`                    | Obtener todas las tareas      |
| POST   | `/tasks`                    | Crear nueva tarea             |
| GET    | `/tasks/:id`                | Obtener tarea específica      |
| PUT    | `/tasks/:id`                | Actualizar tarea              |
| DELETE | `/tasks/:id`                | Eliminar tarea                |
| GET    | `/tasks/status/completed`   | Tareas completadas            |
| GET    | `/tasks/status/incomplete`  | Tareas no completadas         |
| GET    | `/tasks/status/in-progress` | Tareas en progreso            |

---

## 🔍 Ejemplos de Uso

### Crear una tarea

```bash
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d "{\"description\": \"Aprender Node.js\"}"
```

**Respuesta:**

```json
{
  "success": true,
  "message": "Tarea creada exitosamente",
  "data": {
    "id": "abc123def456",
    "description": "Aprender Node.js",
    "status": "todo",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:00:00.000Z"
  }
}
```

### Listar todas las tareas

```bash
curl http://localhost:3000/tasks
```

### Actualizar estado de una tarea

```bash
curl -X PUT http://localhost:3000/tasks/abc123def456 \
  -H "Content-Type: application/json" \
  -d "{\"status\": \"in-progress\"}"
```

### Marcar tarea como completada

```bash
curl -X PUT http://localhost:3000/tasks/abc123def456 \
  -H "Content-Type: application/json" \
  -d "{\"status\": \"done\"}"
```

### Obtener tareas completadas

```bash
curl http://localhost:3000/tasks/status/completed
```

### Eliminar una tarea

```bash
curl -X DELETE http://localhost:3000/tasks/abc123def456
```

---

## 🛠️ Modo Desarrollo

Para desarrollar con auto-reload:

```bash
npm run dev
```

Esto usa **nodemon** para reiniciar el servidor automáticamente cuando hagas cambios.

---

## 📁 Estructura de Datos

Las tareas se guardan en `tasks.json`:

```json
[
  {
    "id": "abc123def456",
    "description": "Aprender Node.js",
    "status": "in-progress",
    "createdAt": "2025-12-16T10:00:00.000Z",
    "updatedAt": "2025-12-16T10:15:00.000Z"
  }
]
```

---

## 🎯 Estados de Tareas

| Estado        | Descripción         |
| ------------- | ------------------- |
| `todo`        | Tarea pendiente     |
| `in-progress` | Tarea en desarrollo |
| `done`        | Tarea completada    |

---

## ❓ Preguntas Frecuentes

**P: ¿Dónde se guardan las tareas?**
R: En el archivo `tasks.json` en la raíz del proyecto.

**P: ¿Qué pasa si elimino el archivo `tasks.json`?**
R: Se recreará automáticamente vacío cuando hagas la próxima solicitud.

**P: ¿Puedo cambiar el puerto?**
R: Sí, modifica `src/index.js` en la línea `const PORT = process.env.PORT || 3000;`

**P: ¿Cómo pruebo desde Postman?**
R: Importa estos endpoints en Postman y prueba.

---

## 📖 Para más información

- Lee `README.md` para documentación completa
- Lee `STRUCTURE.md` para entender la arquitectura
- Revisa `src/index.js` para ver todos los endpoints
- Revisa `src/taskManager.js` para la lógica de negocio

---

## 🐛 Solución de Problemas

**Error: "Cannot find module 'express'"**

- Solución: Ejecuta `npm install`

**Error: "Port 3000 already in use"**

- Solución: Cambia el puerto en `src/index.js` o cierra la aplicación que usa ese puerto

**Error: "EACCES: permission denied"**

- Solución: En Linux/Mac, usa `sudo npm start`

---

¡Listo para empezar! 🎉
