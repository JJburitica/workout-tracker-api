# 🛠️ Guía de Desarrollo - Task Tracker API

Esta guía es para desarrolladores que quieren entender y contribuir al proyecto.

## 📁 Estructura del Proyecto

```
task-tracker/
├── src/
│   ├── index.js           # Servidor Express y endpoints
│   └── taskManager.js     # Lógica de negocio de tareas
├── package.json           # Dependencias y scripts
├── .gitignore            # Archivos ignorados
├── .env.example          # Variables de entorno de ejemplo
├── config.json           # Configuración
├── tasks.json            # Almacenamiento de datos (generado)
├── README.md             # Documentación principal
├── QUICKSTART.md         # Guía de inicio rápido
├── STRUCTURE.md          # Estructura del proyecto
├── TEST_CASES.md         # Casos de prueba
├── postman-collection.json  # Colección para Postman
└── CONTRIBUTING.md       # Esta guía
```

## 🚀 Configuración del Entorno

### 1. Clonar el repositorio

```bash
git clone <repository-url>
cd task-tracker
```

### 2. Instalar dependencias

```bash
npm install
```

### 3. Configurar variables de entorno (opcional)

```bash
cp .env.example .env
```

### 4. Iniciar en modo desarrollo

```bash
npm run dev
```

## 📝 Convenciones de Código

### JavaScript

- Usar `const` por defecto, `let` si es necesario
- Funciones nombreadas (no arrow functions para exportar)
- Comentarios descriptivos para lógica compleja
- Validación de entrada en funciones críticas

### Estructura de Archivos

```javascript
// Imports
const express = require("express");
const taskManager = require("./taskManager");

// Configuración
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Endpoints
app.get("/tasks", (req, res) => {
  // implementación
});

// Exports
module.exports = app;
```

### Nomenclatura

- Archivos: `camelCase.js`
- Funciones: `camelCase()`
- Constantes: `UPPER_CASE`
- Clases: `PascalCase`

## 🔄 Flujo de Trabajo

### 1. Crear una rama para tu cambio

```bash
git checkout -b feature/nombre-del-cambio
```

### 2. Hacer cambios

- Editar archivos
- Mantener consistencia de código
- Agregar comentarios si es necesario

### 3. Probar los cambios

```bash
npm run dev
# En otra terminal
npm test
# O ejecutar pruebas manuales
.\test-examples.ps1
```

### 4. Commit y Push

```bash
git add .
git commit -m "Descripción clara del cambio"
git push origin feature/nombre-del-cambio
```

## 🏗️ Arquitectura

### Capa de Presentación (Express)

```
src/index.js
├── Routing
├── Middleware
├── Validación de entrada
└── Respuestas HTTP
```

### Capa de Negocio (Task Manager)

```
src/taskManager.js
├── Lógica de CRUD
├── Validaciones de negocio
├── Generación de IDs
└── Manejo de estados
```

### Capa de Persistencia (File System)

```
tasks.json
├── Almacenamiento en archivo
├── Lectura/escritura JSON
└── Sincronización de datos
```

## 📚 API Reference

### Funciones principales en `taskManager.js`

#### `initializeTasks()`

Inicializa el archivo de tareas si no existe.

```javascript
taskManager.initializeTasks();
```

#### `getAllTasks()`

Retorna todas las tareas.

```javascript
const tasks = taskManager.getAllTasks();
```

#### `createTask(description)`

Crea una nueva tarea.

```javascript
const task = taskManager.createTask("Nueva tarea");
// Retorna: { id, description, status, createdAt, updatedAt }
```

#### `updateTask(id, updates)`

Actualiza una tarea existente.

```javascript
const task = taskManager.updateTask(id, {
  status: "in-progress",
  description: "Nueva descripción",
});
```

#### `deleteTask(id)`

Elimina una tarea.

```javascript
const deletedTask = taskManager.deleteTask(id);
```

#### `getTasksByStatus(status)`

Obtiene tareas por estado.

```javascript
const inProgressTasks = taskManager.getTasksByStatus("in-progress");
```

## 🐛 Debugging

### Activar logging detallado

```javascript
// En src/index.js
app.use((req, res, next) => {
  console.log(`${req.method} ${req.path}`, req.body);
  next();
});
```

### Inspeccionar archivo de datos

```bash
# Ver contenido de tasks.json
type tasks.json  # Windows
cat tasks.json   # Linux/Mac
```

### Node debugger

```bash
node --inspect src/index.js
# Luego acceder a chrome://inspect
```

## ✅ Testing

### Pruebas Manuales

```bash
# Con PowerShell
.\test-examples.ps1

# Con cURL
curl http://localhost:3000/health
```

### Pruebas Unitarias (futuro)

```bash
npm test
```

## 📦 Agregar Dependencias

### Instalar paquete

```bash
npm install nombre-paquete
# O para desarrollo
npm install --save-dev nombre-paquete
```

### Actualizar package.json

El archivo se actualiza automáticamente.

## 🔐 Validaciones Importantes

### Entrada

```javascript
// Validar descripción
if (!description || description.trim() === "") {
  throw new Error("La descripción es requerida");
}

// Validar estado
if (!["todo", "in-progress", "done"].includes(status)) {
  throw new Error("Estado inválido");
}
```

### Salida

```javascript
// Siempre retornar respuestas consistentes
res.status(200).json({
  success: true,
  data: resultado,
  message: "Descripción opcional",
});
```

## 🚀 Deployamiento

### Preparar para producción

```javascript
// En .env
NODE_ENV = production;
PORT = 3000;
```

### Ejecutar en producción

```bash
npm start
```

### Usando PM2 (recomendado)

```bash
npm install -g pm2
pm2 start src/index.js --name "task-tracker"
pm2 save
pm2 startup
```

## 📋 Checklist de Contribución

- [ ] Código sigue convenciones del proyecto
- [ ] Cambios probados manualmente
- [ ] Comentarios agregados donde sea necesario
- [ ] Sin errores de consola
- [ ] Commits con mensajes claros
- [ ] Documentación actualizada si es necesario

## 🤝 Contribuciones Bienvenidas

Tipos de contribuciones:

- 🐛 Arreglo de bugs
- ✨ Nuevas características
- 📚 Mejoras de documentación
- 🚀 Optimizaciones de rendimiento
- 🧪 Casos de prueba

## 📞 Soporte

Para preguntas o problemas:

1. Revisa la documentación (README.md)
2. Busca en issues cerrados
3. Crea un nuevo issue describiendo el problema

## 📄 Licencia

ISC - Revisa LICENSE.md

---

¡Gracias por contribuir! 🎉
