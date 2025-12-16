const fs = require("fs");
const path = require("path");

const TASKS_FILE = path.join(__dirname, "../tasks.json");
const COUNTER_FILE = path.join(__dirname, "../counter.json");

// Inicializar contador si no existe
function initializeCounter() {
  if (!fs.existsSync(COUNTER_FILE)) {
    fs.writeFileSync(COUNTER_FILE, JSON.stringify({ nextId: 1 }, null, 2));
  }
}

// Obtener el siguiente ID e incrementar el contador
function getNextId() {
  try {
    const data = fs.readFileSync(COUNTER_FILE, "utf-8");
    const counter = JSON.parse(data);
    const nextId = counter.nextId;

    // Incrementar y guardar
    counter.nextId++;
    fs.writeFileSync(COUNTER_FILE, JSON.stringify(counter, null, 2));

    return nextId;
  } catch (error) {
    console.error("Error leyendo contador:", error);
    return 1;
  }
}

// Inicializar el archivo de tareas si no existe
function initializeTasks() {
  initializeCounter();
  if (!fs.existsSync(TASKS_FILE)) {
    fs.writeFileSync(TASKS_FILE, JSON.stringify([], null, 2));
  }
}

// Leer todas las tareas
function getAllTasks() {
  try {
    const data = fs.readFileSync(TASKS_FILE, "utf-8");
    return JSON.parse(data);
  } catch (error) {
    console.error("Error leyendo tareas:", error);
    return [];
  }
}

// Guardar tareas al archivo
function saveTasks(tasks) {
  try {
    fs.writeFileSync(TASKS_FILE, JSON.stringify(tasks, null, 2));
    return true;
  } catch (error) {
    console.error("Error guardando tareas:", error);
    return false;
  }
}

// Crear una nueva tarea
function createTask(description) {
  if (!description || description.trim() === "") {
    throw new Error("La descripción es requerida");
  }

  const tasks = getAllTasks();
  const newTask = {
    id: getNextId(),
    description: description.trim(),
    status: "todo",
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  };

  tasks.push(newTask);
  saveTasks(tasks);
  return newTask;
}

// Obtener una tarea por ID
function getTaskById(id) {
  const tasks = getAllTasks();
  const numId = parseInt(id);
  return tasks.find((task) => task.id === numId || task.id === id);
}

// Actualizar una tarea
function updateTask(id, updates) {
  const tasks = getAllTasks();
  const numId = parseInt(id);
  const taskIndex = tasks.findIndex(
    (task) => task.id === numId || task.id === id
  );

  if (taskIndex === -1) {
    throw new Error("Tarea no encontrada");
  }

  // Validar que el estado sea válido si se proporciona
  if (
    updates.status &&
    !["todo", "in-progress", "done"].includes(updates.status)
  ) {
    throw new Error("Estado inválido. Debe ser: todo, in-progress o done");
  }

  // Actualizar solo los campos permitidos
  if (updates.description !== undefined) {
    tasks[taskIndex].description = updates.description.trim();
  }
  if (updates.status !== undefined) {
    tasks[taskIndex].status = updates.status;
  }

  tasks[taskIndex].updatedAt = new Date().toISOString();
  saveTasks(tasks);
  return tasks[taskIndex];
}

// Eliminar una tarea
function deleteTask(id) {
  const tasks = getAllTasks();
  const numId = parseInt(id);
  const taskIndex = tasks.findIndex(
    (task) => task.id === numId || task.id === id
  );

  if (taskIndex === -1) {
    throw new Error("Tarea no encontrada");
  }

  const deletedTask = tasks.splice(taskIndex, 1)[0];
  saveTasks(tasks);
  return deletedTask;
}

// Obtener tareas por estado
function getTasksByStatus(status) {
  const validStatuses = ["todo", "in-progress", "done"];
  if (!validStatuses.includes(status)) {
    throw new Error("Estado inválido. Debe ser: todo, in-progress o done");
  }

  const tasks = getAllTasks();
  return tasks.filter((task) => task.status === status);
}

// Obtener tareas completadas
function getCompletedTasks() {
  return getTasksByStatus("done");
}

// Obtener tareas no completadas
function getIncompleteTasks() {
  const tasks = getAllTasks();
  return tasks.filter((task) => task.status !== "done");
}

// Obtener tareas en progreso
function getInProgressTasks() {
  return getTasksByStatus("in-progress");
}

module.exports = {
  initializeTasks,
  getAllTasks,
  createTask,
  getTaskById,
  updateTask,
  deleteTask,
  getTasksByStatus,
  getCompletedTasks,
  getIncompleteTasks,
  getInProgressTasks,
};
