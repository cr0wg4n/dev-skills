# Informe de Revisión de Código Vue.js
**Timestamp**: 2026-06-14 22:48:06
**Overall Quality**: Poor

## Issues Found

1. **Issue 1**: Uso de Options API en lugar de Composition API con `<script setup>`.
    - **Severity**: Medium.
    - **Description**: Ambos componentes (`Todo.vue` y `TodoItem.vue`) usan `defineComponent` con Options API (`data`, `methods`, `props`, `emits`). La guía indica preferir Composition API con `<script setup lang="ts">`, que es más conciso, mejora la inferencia de tipos y reduce boilerplate.
    - **Location**: `src/components/Todo.vue` (líneas 24-57), `src/components/TodoItem.vue` (líneas 8-29).
    - **Recommendation**: Reescribir ambos componentes usando `<script setup lang="ts">`, reemplazando `data()` por `ref`/`reactive`, `methods` por funciones normales, y `defineProps`/`defineEmits` para props y eventos.

2. **Issue 2**: Orden de los bloques `<template>` y `<script>` invertido.
    - **Severity**: Low.
    - **Description**: La guía indica colocar el bloque `<script>` antes del `<template>` para poder leer la lógica y dependencias de un vistazo antes de la plantilla. En ambos archivos el `<template>` aparece primero.
    - **Location**: `src/components/Todo.vue` (líneas 1-22 vs 24-57), `src/components/TodoItem.vue` (líneas 1-6 vs 8-29).
    - **Recommendation**: Mover el bloque `<script>` para que aparezca antes del `<template>` en ambos archivos.

3. **Issue 3**: Nombres de variables y props poco descriptivos.
    - **Severity**: Medium.
    - **Description**: Variables como `n` y `stuff` en `Todo.vue`, y el prop `x` en `TodoItem.vue`, no comunican su propósito. Esto reduce la legibilidad y dificulta el mantenimiento futuro, violando la guía de usar nombres claros y descriptivos.
    - **Location**: `src/components/Todo.vue` (líneas 35-40, 44-48), `src/components/TodoItem.vue` (líneas 14-17, todo el archivo).
    - **Recommendation**: Renombrar `n` → `newTodoText`, `stuff` → `todos`, y el prop `x` → `todo` (con su interfaz correspondiente, ver Issue 6).

4. **Issue 4**: Nombres de métodos no descriptivos y sin prefijo `handle` para event handlers.
    - **Severity**: High.
    - **Description**: Los métodos `a` y `b` en `TodoItem.vue` son ininteligibles sin leer el cuerpo completo, lo que es un riesgo serio de mantenibilidad y propenso a errores al modificar el código. Además, `addOne`, `flipIt` y `byeBye` en `Todo.vue` son handlers de eventos (submit del formulario y eventos emitidos por `TodoItem`) y deberían usar el prefijo `handle` según la guía.
    - **Location**: `src/components/TodoItem.vue` (líneas 21-26), `src/components/Todo.vue` (líneas 43-54).
    - **Recommendation**: Renombrar `a` → `handleToggle`, `b` → `handleDelete` en `TodoItem.vue`; y `addOne` → `handleAddTodo`, `flipIt` → `handleToggleTodo`, `byeBye` → `handleDeleteTodo` en `Todo.vue`.

5. **Issue 5**: Nombre de componente en `name` no sigue PascalCase.
    - **Severity**: Low.
    - **Description**: La opción `name: 'todoitem'` en `TodoItem.vue` no respeta la convención PascalCase para nombres de componentes, lo cual es inconsistente con `Todo.vue` que sí usa `name: 'Todo'`.
    - **Location**: `src/components/TodoItem.vue` (línea 12).
    - **Recommendation**: Cambiar a `name: 'TodoItem'`.

6. **Issue 6**: Falta de interfaz dedicada para las props.
    - **Severity**: Medium.
    - **Description**: `TodoItem.vue` define el prop `x` inline con `PropType<{ text: string; done: boolean }>` en lugar de declarar una interfaz separada (p. ej. `TodoItemProps`), tal como recomienda la guía para mejorar la seguridad de tipos y la mantenibilidad.
    - **Location**: `src/components/TodoItem.vue` (líneas 13-18).
    - **Recommendation**: Definir una interfaz `TodoItemProps` (con un campo `todo: { text: string; done: boolean }`) y usarla en `defineProps<TodoItemProps>()` al migrar a `<script setup>`.

7. **Issue 7**: Nombres de eventos emitidos poco descriptivos.
    - **Severity**: Low.
    - **Description**: Los eventos `flip` y `erase` emitidos por `TodoItem.vue` no describen claramente la acción sobre el dato (un "todo"), a diferencia de ejemplos como `updateUser` o `deleteItem` sugeridos por la guía.
    - **Location**: `src/components/TodoItem.vue` (línea 19, líneas 22 y 25).
    - **Recommendation**: Renombrar los eventos a `toggle-todo` y `delete-todo` (o `toggleTodo`/`deleteTodo`), actualizando también los listeners `@flip`/`@erase` en `Todo.vue` (líneas 17-18).

8. **Issue 8**: Lógica de la lista de tareas embebida directamente en el componente, sin extraer a un composable.
    - **Severity**: Medium.
    - **Description**: El estado (`stuff`, `n`) y la lógica de manipulación de la lista (agregar, marcar, eliminar) viven directamente dentro de `Todo.vue`. La guía recomienda separar responsabilidades organizando la lógica reutilizable en composables (p. ej. `useTodos`), facilitando pruebas y reutilización.
    - **Location**: `src/components/Todo.vue` (líneas 33-55).
    - **Recommendation**: Extraer el estado y los métodos relacionados con las tareas a un composable `useTodos` (p. ej. `src/composables/useTodos.ts`), que retorne `todos`, `addTodo`, `toggleTodo` y `removeTodo`, y consumirlo desde `Todo.vue`.
