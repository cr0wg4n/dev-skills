# Vue.js Code Review Feedback
**Timestamp**: 2026-06-14 22:34:04
**Overall Quality**: Poor

## Issues Found
1. **Issue 1**: Options API used instead of Composition API with `<script setup>`
  - **Description**: Component uses `defineComponent` with `data()` and `methods` instead of `<script setup>` + Composition API. This contradicts the project's own stated guideline (Composition API preferred) and makes the code more verbose and harder to maintain.
  - **Severity**: Medium.
  - **Location**: src/components/Todo.vue, lines 24-57.
  - **Recommendation**: Rewrite using `<script setup lang="ts">`, `ref`/`reactive` for `n` and `stuff`, and plain functions for `addOne`, `flipIt`, `byeBye`.

2. **Issue 2**: `<script>` block placed after `<template>` block
  - **Description**: Convention is to place `<script>` before `<template>` so logic/dependencies are visible before the markup.
  - **Severity**: Low.
  - **Location**: src/components/Todo.vue, lines 1-57.
  - **Recommendation**: Move the `<script>` block above `<template>`.

3. **Issue 3**: Non-descriptive variable names `n` and `stuff`
  - **Description**: `n` (the input model) and `stuff` (the todo list) give no indication of purpose, hurting readability and maintainability.
  - **Severity**: Medium.
  - **Location**: src/components/Todo.vue, lines 35-40.
  - **Recommendation**: Rename `n` to `newTodoText` and `stuff` to `todos` (or `todoList`).

4. **Issue 4**: Event handler methods not using `handle` prefix
  - **Description**: `addOne`, `flipIt`, `byeBye` are all event handlers (form submit, child emits) but don't follow the `handle*` naming convention, making it hard to distinguish handlers from other logic.
  - **Severity**: Medium.
  - **Location**: src/components/Todo.vue, lines 43-54 (and template lines 5, 17-18).
  - **Recommendation**: Rename to `handleAddTodo`, `handleToggleDone`, `handleDeleteTodo` (and update template references).

5. **Issue 5**: Prop named `x` with no dedicated props interface
  - **Description**: The prop `x` gives no indication of what data it carries. No `Props` interface is defined as recommended, reducing type-safety clarity at the call site.
  - **Severity**: Medium.
  - **Location**: src/components/TodoItem.vue, lines 13-18 (and src/components/Todo.vue, line 16).
  - **Recommendation**: Rename prop to `todo`, define `interface TodoItemProps { todo: Todo }`, and use `:todo="t"` in the parent template.

6. **Issue 6**: Options API used instead of Composition API with `<script setup>`
  - **Description**: Same issue as Todo.vue — uses `defineComponent` with `methods` instead of `<script setup>`.
  - **Severity**: Medium.
  - **Location**: src/components/TodoItem.vue, lines 8-29.
  - **Recommendation**: Rewrite using `<script setup lang="ts">` with `defineProps` and `defineEmits`.

7. **Issue 7**: `<script>` block placed after `<template>` block
  - **Description**: Same ordering issue as Todo.vue.
  - **Severity**: Low.
  - **Location**: src/components/TodoItem.vue, lines 1-29.
  - **Recommendation**: Move the `<script>` block above `<template>`.

8. **Issue 8**: Component name `'todoitem'` not in PascalCase
  - **Description**: The internal component `name` option is lowercase, breaking the PascalCase naming convention for components and inconsistent with the filename `TodoItem.vue`.
  - **Severity**: Low.
  - **Location**: src/components/TodoItem.vue, line 12.
  - **Recommendation**: Change `name: 'todoitem'` to `name: 'TodoItem'`.

9. **Issue 9**: Methods named `a` and `b` with no descriptive purpose
  - **Description**: Single-letter method names give zero indication of behavior (toggling done state, deleting item), severely hurting readability and making the code hard to maintain or debug.
  - **Severity**: Medium.
  - **Location**: src/components/TodoItem.vue, lines 21-26 (and template lines 3-4).
  - **Recommendation**: Rename `a` to `handleToggle` and `b` to `handleDelete` (update template `@click` bindings accordingly).

10. **Issue 10**: Generic emit names `flip` and `erase`
  - **Description**: Emitted event names should clearly describe the action taken on the data; `flip` and `erase` are vague, especially `erase` which doesn't indicate what is being erased.
  - **Severity**: Low.
  - **Location**: src/components/TodoItem.vue, line 19 (and src/components/Todo.vue, lines 17-18).
  - **Recommendation**: Rename emits to `toggle-done` and `delete-item` (or `update-todo` / `remove-todo`), updating both `emits` array and parent template listeners.
