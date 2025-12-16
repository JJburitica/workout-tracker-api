const express = require("express");
const taskManager = require("./taskManager");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Inicializar archivo de tareas
taskManager.initializeTasks();

// Middleware de logging (opcional)
app.use((req, res, next) => {
  console.log(`${req.method} ${req.path}`);
  next();
});

// ==================== ENDPOINTS ====================

/**
 * GET /tasks
 * Obtener todas las tareas
 */
app.get("/tasks", (req, res) => {
  try {
    const tasks = taskManager.getAllTasks();
    res.status(200).json({
      success: true,
      count: tasks.length,
      data: tasks,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Error al obtener las tareas",
    });
  }
});

/**
 * POST /tasks
 * Crear una nueva tarea
 */
app.post("/tasks", (req, res) => {
  try {
    const { description } = req.body;

    if (!description) {
      return res.status(400).json({
        success: false,
        error: "La descripción es requerida",
      });
    }

    const newTask = taskManager.createTask(description);
    res.status(201).json({
      success: true,
      message: "Tarea creada exitosamente",
      data: newTask,
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      error: error.message,
    });
  }
});

/**
 * GET /tasks/:id
 * Obtener una tarea específica por ID
 */
app.get("/tasks/:id", (req, res) => {
  try {
    const { id } = req.params;
    const task = taskManager.getTaskById(id);

    if (!task) {
      return res.status(404).json({
        success: false,
        error: "Tarea no encontrada",
      });
    }

    res.status(200).json({
      success: true,
      data: task,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Error al obtener la tarea",
    });
  }
});

/**
 * PUT /tasks/:id
 * Actualizar una tarea
 */
app.put("/tasks/:id", (req, res) => {
  try {
    const { id } = req.params;
    const { description, status } = req.body;

    // Validar que al menos un campo se proporcione
    if (!description && !status) {
      return res.status(400).json({
        success: false,
        error:
          "Proporcione al menos un campo para actualizar (description o status)",
      });
    }

    const updatedTask = taskManager.updateTask(id, { description, status });
    res.status(200).json({
      success: true,
      message: "Tarea actualizada exitosamente",
      data: updatedTask,
    });
  } catch (error) {
    if (error.message === "Tarea no encontrada") {
      return res.status(404).json({
        success: false,
        error: error.message,
      });
    }
    res.status(400).json({
      success: false,
      error: error.message,
    });
  }
});

/**
 * DELETE /tasks/:id
 * Eliminar una tarea
 */
app.delete("/tasks/:id", (req, res) => {
  try {
    const { id } = req.params;
    const deletedTask = taskManager.deleteTask(id);

    res.status(200).json({
      success: true,
      message: "Tarea eliminada exitosamente",
      data: deletedTask,
    });
  } catch (error) {
    if (error.message === "Tarea no encontrada") {
      return res.status(404).json({
        success: false,
        error: error.message,
      });
    }
    res.status(400).json({
      success: false,
      error: error.message,
    });
  }
});

// ==================== FILTROS POR ESTADO ====================

/**
 * GET /tasks/status/completed
 * Obtener todas las tareas completadas
 */
app.get("/tasks/status/completed", (req, res) => {
  try {
    const tasks = taskManager.getCompletedTasks();
    res.status(200).json({
      success: true,
      count: tasks.length,
      data: tasks,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Error al obtener las tareas completadas",
    });
  }
});

/**
 * GET /tasks/status/incomplete
 * Obtener todas las tareas no completadas
 */
app.get("/tasks/status/incomplete", (req, res) => {
  try {
    const tasks = taskManager.getIncompleteTasks();
    res.status(200).json({
      success: true,
      count: tasks.length,
      data: tasks,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Error al obtener las tareas no completadas",
    });
  }
});

/**
 * GET /tasks/status/in-progress
 * Obtener todas las tareas en progreso
 */
app.get("/tasks/status/in-progress", (req, res) => {
  try {
    const tasks = taskManager.getInProgressTasks();
    res.status(200).json({
      success: true,
      count: tasks.length,
      data: tasks,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Error al obtener las tareas en progreso",
    });
  }
});

/**
 * GET /tasks/status/:status
 * Obtener tareas por estado específico (todo, in-progress, done)
 */
app.get("/tasks/status/:status", (req, res) => {
  try {
    const { status } = req.params;
    const tasks = taskManager.getTasksByStatus(status);

    res.status(200).json({
      success: true,
      count: tasks.length,
      data: tasks,
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      error: error.message,
    });
  }
});

// ==================== SALUD DE LA API ====================

/**
 * GET /health
 * Verificar que el servidor está funcionando
 */
app.get("/health", (req, res) => {
  res.status(200).json({
    success: true,
    message: "El servidor Task Tracker está funcionando correctamente",
    timestamp: new Date().toISOString(),
  });
});

// ==================== MANEJO DE ERRORES ====================

// Manejar rutas no encontradas
app.use((req, res) => {
  res.status(404).json({
    success: false,
    error: "Ruta no encontrada",
    path: req.path,
    method: req.method,
  });
});

// Manejar errores generales
app.use((err, req, res, next) => {
  console.error("Error:", err);
  res.status(500).json({
    success: false,
    error: "Error interno del servidor",
  });
});

// ==================== INICIAR SERVIDOR ====================

app.listen(PORT, () => {
  console.log(`
╔════════════════════════════════════════╗
║  Task Tracker API iniciado             ║
║  Escuchando en puerto: ${PORT}         ║
║  http://localhost:${PORT}                ║
╚════════════════════════════════════════╝
  `);
});

module.exports = app;
