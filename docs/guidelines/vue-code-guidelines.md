# Vue Code Guidelines

Version: 1.1.0 · Last updated: 2026-11-17

## 1. Naming

These rules are shared between the Vue and TypeScript guidelines and must stay identical in both documents.

- Use camelCase for variables, functions, and parameters.
- Use PascalCase for classes, interfaces, types, enums, and components.
- Use UPPER_SNAKE_CASE for module-level constants that never change.
- Use PascalCase for enum names and enum members, e.g. `UserRole.Admin`.
- Use lowercase strings for string literal union members, e.g. `'asc' | 'desc'`.
- Prefix boolean variables and props with `is`, `has`, `can`, or `should`, e.g. `isActive`, `hasPermission`.
- Use descriptive names that state the purpose. Avoid abbreviations unless they are widely understood.
- Use `function` declarations for named functions and methods. Use arrow functions for inline callbacks.
- Name files in lowercase, with the file's type as a middle segment: `.util.ts`, `.service.ts`, `.store.ts`, `.schema.ts`, `.type.ts`. For example: `http.service.ts`, `date.util.ts`, `auth.store.ts`, `login.schema.ts`, `auth.type.ts`.
- Name composables `useX.ts` after their purpose, e.g. `useForm.ts`, `useAuth.ts`.

### Vue-specific naming

- Name components with the highest-level word first and a descriptive modifier last, e.g. `UserProfileBadge`, `SearchButtonClear`, `LoginFormHeader`.
- Prefix components that only one parent uses with the parent's name, e.g. `ParentComponentChild`, `ParentComponentItem`.
- Name event handlers with the `handle` prefix, e.g. `handleClick`, `handleSubmit`.
- Name emitted events with the verbose form that states the outcome, e.g. `updateTodo`, `deleteTodo`, `closeModal`. Do not shorten them to `update` or `delete`.
- Name props for their purpose, e.g. `userData`, `isVisible`, `itemsList`. Use camelCase in script and kebab-case in the template: `user-data`.

## 2. Code Structure and Organization

- Use a clear and consistent file structure for components, views, and other assets.
- Separate concerns by organizing code into presentational components, container components, composables, types, constants, services, and utility functions.
- Use single-file components (SFCs) to encapsulate template, script, and style in one file for better maintainability.
- In an SFC, use the `<script setup>` syntax for a more concise way to write components. Prefer the Composition API over the Options API.
- In an SFC, place the `<script>` block before the `<template>` block. The logic and dependencies are easy to read at a glance before the template.
- Follow the folder structure below as a general guideline. Adjust it to the needs of the project.

```
  src/
  ├── app/                        # Bootstrap global
  │   ├── App.vue
  │   ├── main.ts
  │   └── router.ts               # Import routes from features and create router instance
  │
  ├── core/                       # Shared between features
  │   ├── components/             # Generic UI (Button, Modal, Input)
  │   ├── composables/            # useAuth.ts, usePagination.ts
  │   ├── services/               # http.service.ts, storage.service.ts
  │   ├── stores/                 # auth.store.ts, ui.store.ts (Pinia)
  │   ├── types/                  # common.type.ts
  │   ├── constants/              # Constants
  │   └── utils/                  # date.util.ts, format.util.ts, string.util.ts
  │
  ├── features/
  │   ├── auth/
  │   │   ├── components/         # LoginForm.vue, RegisterForm.vue
  │   │   ├── composables/        # useLogin.ts, useRegister.ts
  │   │   ├── services/           # auth.service.ts
  │   │   ├── stores/             # auth.store.ts
  │   │   ├── types/              # auth.type.ts
  │   │   ├── schemas/            # Only if using a validation library like Zod or Yup: login.schema.ts, register.schema.ts
  │   │   ├── utils/              # Only if applicable: utilities specific to this feature (e.g. auth.util.ts)
  │   │   ├── views/              # LoginView.vue, RegisterView.vue
  │   │   ├── index.ts            # The feature's public API (see the rule below)
  │   │   └── routes.ts           # { path: '/login', ... }
  │   │
  │   ├── ...
  │   │
  │   └── products/               # Same pattern for other features
  │       ├── components/
  │       │   ├── ProductCard.vue
  │       │   ├── ProductList.vue
  │       │   └── ProductCardSkeleton.vue
  │       ├── composables/
  │       │   └── useProducts.ts
  │       ├── services/
  │       │   └── product.service.ts
  │       ├── stores/
  │       │   └── product.store.ts
  │       ├── types/
  │       │   └── product.type.ts
  │       ├── schemas/
  │       │   └── product.schema.ts
  │       ├── utils/
  │       │   └── product.util.ts
  │       ├── views/
  │       │   ├── ProductsView.vue
  │       │   └── ProductDetailView.vue
  │       ├── index.ts
  │       └── routes.ts
  │
  ├── layouts/                    # DefaultLayout.vue, AuthLayout.vue
  └── assets/
```

- `index.ts` is the feature's public API: code in other features imports from it. Code inside the same feature imports from the file that defines the symbol. Do not re-export everything from a barrel file, because it pulls unused code into bundles and hurts tree-shaking.
- The order of code inside a component matters. Use this order:
  1. Props and emits definitions (using `defineProps` and `defineEmits` with proper interfaces or types)
  2. Refs and reactive state
  3. Composables
  4. Computed properties
  5. Watchers
  6. Functions
  7. Lifecycle hooks (e.g., `onMounted`, `onUnmounted`, ...)

## 3. Props

- Define a separate interface for the props object, and use it in the component definition for type safety and maintainability:
```vue
<!-- TodoContainer.vue -->
<script setup lang="ts">
  interface TodoContainerProps {
    todos: Array<Todo>;
    isLoading: boolean;
  }

  const props = defineProps<TodoContainerProps>();
</script>
```
- Set default values with `withDefaults`:
```vue
<!-- ButtonBase.vue -->
<script setup lang="ts">
  enum ButtonSize {
    Small = 'small',
    Large = 'large',
  }

  interface ButtonBaseProps {
    label: string;
    size?: ButtonSize;
  }

  const props = withDefaults(defineProps<ButtonBaseProps>(), {
    size: ButtonSize.Small,
  });
</script>
```
- Avoid `watch` on props. Derive values with computed properties instead:
```vue
<!-- UserProfile.vue -->
<script setup lang="ts">
  interface UserProfileProps {
    user: User;
  }

  const props = defineProps<UserProfileProps>();

  const fullName = computed(() => `${props.user.firstName} ${props.user.lastName}`);
</script>
```
- A prop watcher is rarely needed. Use one only for a side effect that a prop change must trigger, such as loading data when `userId` changes:
```ts
watch(() => props.userId, (userId) => {
  loadUser(userId);
});
```
- Avoid passing functions or methods as props. Use event emitters to communicate from child to parent.
- Avoid prop drilling. Passing a prop through more than two component levels is prop drilling; use `provide`/`inject` or a store instead.
- Props are immutable. Do not modify props in a child component, because it causes unexpected behavior.

## 4. Event Handling and Emitting

- Declare the events a component can emit with `defineEmits`, for type safety.
- Do not use `$emit` in templates. Use the `emit` function returned by `defineEmits` in the script section.
- Give the `defineEmits` definition a dedicated interface that describes the events:
```vue
<!-- TodoItem.vue -->
<script setup lang="ts">
  interface TodoItemEmits {
    (event: 'updateTodo', payload: { id: number; completed: boolean }): void;
    (event: 'deleteTodo', payload: { id: number }): void;
  }

  const emit = defineEmits<TodoItemEmits>();
  ...
</script>
```

## 5. Computed Properties

- Prefer computed properties over methods for values derived from reactive data.
- Use computed properties to cache expensive calculations.
- Avoid side effects in computed properties. They derive values; they do not perform actions or modify state.
- When `watch` is used to derive values, consider whether a computed property is the better choice.
- Do not perform asynchronous operations in computed properties. Use methods or composables for async logic.

## 6. Watchers

- Use watchers for side effects in response to changes in reactive data. Do not use them for simple derivation that a computed property can handle.
- Clean up watchers that are tied to data which is destroyed or recreated during the component's lifecycle, to avoid memory leaks.
- Avoid deep watchers unless they are necessary. They are expensive.
- Watch the specific values you react to. A non-deep watcher on a whole object fires only when the reference is replaced, not when a nested property changes, so it misses most edits. If you truly need every nested change, use `deep: true` sparingly.
```vue
<!-- UserProfile.vue -->
<script setup lang="ts">
  ...
  const { user } = useUserProfile();

  // Fires only when `user` itself is replaced, not when `user.value.firstName` changes
  watch(user, (newUser) => {
    // Handle a replaced user
  });

  // Preferred: watch the specific values that matter
  watch(() => user.value.firstName, (newFirstName) => {
    // Handle first name changes
  });
  watch(() => user.value.lastName, (newLastName) => {
    // Handle last name changes
  });
</script>
```

## 7. Templating

- Use `v-for` with a stable, unique `key` on every item, so the framework can reuse elements efficiently.
- Use `v-show` for elements that are toggled often, and `v-if` for elements that are rarely toggled.
- Avoid `v-html` unless it is necessary. Without sanitization it can lead to XSS.
- When a component has many attributes, bind them with `v-bind` and computed properties. Bind listeners with `v-on` to a method reference, e.g. `@click="handleClick"`.
- Avoid complex logic in templates. Move it to computed properties or methods:
```vue
<!-- UserProfile.vue -->
<template>
  <!-- Avoid complex logic in templates -->
  <div v-if="user.isActive && user.age > 18">
    <!-- User profile content -->
  </div>
</template>
<script setup lang="ts">
  ...
  // Instead, move complex logic to computed properties
  const isActiveAdult = computed(() => user.value.isActive && user.value.age > 18);
</script>
```
- Use `<style scoped>` by default so component styles do not leak. Reserve global styles for design tokens and resets.
- Use classes for styles that never change. Use `:class` and `:style` bindings for values that change at runtime, rather than hard-coded inline `style` attributes.
- Render explicit loading and error states for async data, so the template never shows empty or stale content by accident.
- Use slots for reusable components that accept dynamic content, and named slots when a component has several slots.
- Keep templates shallow. Break deeply nested templates into smaller components.
- Do not use `v-if` and `v-for` on the same element. Use a computed property to filter the list before rendering it with `v-for`.

## 8. Reactivity and Dependency Injection

- Use `ref` for primitives and for values you replace. Use `reactive` for objects you change field by field. When unsure, use `ref`, because it stays consistent after reassignment.
- Destructuring a `reactive` object loses reactivity. Use `toRefs` to keep it, or keep the object intact.
- Use `shallowRef` for large data that is read but not mutated deeply, so Vue does not make every nested field reactive. Use `markRaw` for objects that must never be proxied, such as instances of third-party classes.
- Type `provide`/`inject` with an `InjectionKey`, so the injected value keeps its type:
```ts
import type { InjectionKey } from 'vue';

export const currentUserKey: InjectionKey<User> = Symbol('currentUser');

provide(currentUserKey, user);

const currentUser = inject(currentUserKey); // typed as User | undefined
```

## 9. Composables

- Use composables to encapsulate reusable logic and state across components.
- Use composables for logic tied to component behavior and reactivity, such as form handling or data fetching. Use services or plain TypeScript modules for general logic like API calls, authentication, or utilities. Composables can use services and utilities, but services and utilities must not use composables.
- A composable must not manipulate the DOM or perform side effects unrelated to its core job. Return reactive data and methods, and let the component handle the DOM.
- A composable exposes a clear, well-defined API, so components can use it without knowing its internals.
- Avoid lifecycle hooks inside composables. Expose methods such as `start()` and `stop()` instead, and call them from the component's lifecycle hooks.
- Avoid composables for global state. Use a store such as Pinia.

## 10. Services and Utility Functions

- Use services for logic related to API calls, authentication, or business logic that is not tied to component behavior or lifecycle.
- Use utility modules for general-purpose functions reused across the application or a feature, such as date formatting or string manipulation.
- Services and utility modules must not manipulate the DOM or perform side effects unrelated to their core job. They return data or perform actions that components or composables use.
- Services and utility modules expose a clear, well-defined API, so callers do not need to know their internals.

## 11. Design Patterns

- Follow the single responsibility principle for components, composables, services, and utility modules. Each has one clear, focused purpose.
- Use the container/presentational pattern. Container components fetch data and manage state. Presentational components render UI from props.
- Use the Composition API and composables to share logic across components and features.
- Use `provide`/`inject` to share data across several component levels without prop drilling, but use it judiciously. Prefer a store such as Pinia for global state.
- Use slots for flexible, reusable components. Use named slots when a component has several.

## 12. Miscellaneous

- Use `defineModel` for two-way binding when appropriate. It is more concise than manual `v-model` wiring.
- When a single file grows too long (for example, more than 350 lines), split it into smaller components, composables, services, or utility modules.
- Prefer `async`/`await` over `.then()` and `.catch()` chains.
- Lazy-load non-critical sub-components with dynamic imports to improve initial load time.
