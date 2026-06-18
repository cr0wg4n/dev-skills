# Vue Code Guidelines

### 1. Code Structure and Organization
- Use a clear and consistent file structure for components, views, and other assets.
- Separate concerns by organizing code into presentational components, container components, composables, types, constants, services, and utility functions.
- Use single-file components (SFCs) to encapsulate template, script, and style in one file for better maintainability.
- In a SFC use the `<script setup>` syntax for a more concise and efficient way to write components, so prefer Composition API over Options API.
- In a SFC, place the `<script>` block before the `<template>` block for better readability and to follow common conventions, as it is easy to read the logic and dependencies at a glance before diving into the template.
- The code should follow the next folder structure as a general guideline, but it can be adjusted based on the specific needs of the project:

```
  src/
  ├── app/                        # Bootstrap global
  │   ├── App.vue
  │   ├── main.ts
  │   └── router.ts               # Import routes from features and create router instance
  │
  ├── core/                       # Shared between features
  │   ├── components/             # Generic UI (Button, Modal, Input)
  │   ├── composables/            # useAuth, usePagination
  │   ├── services/               # http.ts, storage.ts
  │   ├── stores/                 # Pinia: auth, ui
  │   ├── types/                  # Interfaces and types
  │   ├── constants/              # Constants
  │   └── utils/                  # date.ts, format.ts, string.ts
  │
  ├── features/
  │   ├── auth/
  │   │   ├── components/         # LoginForm.vue, RegisterForm.vue
  │   │   ├── composables/        # useLogin.ts, useRegister.ts
  │   │   ├── services/           # auth.service.ts
  │   │   ├── stores/             # auth.store.ts
  │   │   ├── types/              # auth.types.ts
  │   │   ├── schemas/            # Only if using a validation library like Yup, Zod or others, to define validation schemas for forms or payloads (e.g., loginSchema.schema.ts, registerSchema.schema.ts)
  │   │   ├── utils/              # Only if applicable, place to define utility functions that are specific to the feature and are not shared across the application
  │   │   ├── views/              # LoginView.vue, RegisterView.vue
  │   │   ├── index.ts            # Export components, composables, services, stores, types, views... from the feature, as a single entry point for the feature
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
  │       │   └── products.service.ts
  │       ├── stores/
  │       │   └── products.store.ts
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
- Order in components is important the correct order is: 
  1. Props and emits definitions (using `defineProps` and `defineEmits` with proper interfaces/types)
  2. Refs and reactive state
  3. Composables
  4. Computed properties 
  5. Watchers
  6. Functions
  7. Lifecycle hooks (e.g., `onMounted`, `onUnmounted`, ...)


### 2. Naming Conventions
- Use camelCase for variable and function names.
- Use PascalCase for component names.
- Use meaningful and descriptive names for variables, functions, and components.
- Avoid abbreviations unless they are widely understood.
- For component names, use a clear and descriptive name that indicates the purpose of the component; names should start with the highest-level words and end with descriptive modifiers. (e.g., `UserProfileBadge`, `SearchButtonClear`, `LoginFormHeader`).
- For subcomponents or components that are only used within a specific parent component, consider using a prefix that indicates their relationship (e.g., `ParentComponentChild`, `ParentComponentItem`, `ParentComponentHeader` when the parent component is `ParentComponent`; these are just examples).
- Prefer traditional function definitions over arrow functions for defining methods/functions in Vue components.
- For event handlers, use the `handle` prefix (e.g., `handleClick`, `handleSubmit`) to clearly indicate their purpose.
- For event emitters, use clear and descriptive names that indicate the event being emitted (e.g., `updateUser`, `deleteItem`, `closeModal`).
- For props, use clear and descriptive names that indicate the purpose of the prop (e.g., `userData`, `isVisible`, `itemsList`).
- For props, use camelCase in the script code and kebab-case in the template when passing props to components (e.g., `userData` in the script and `user-data` in the template).
- For composables, use a clear and descriptive name that indicates the purpose of the composable (e.g., `useForm`, `useAuth`, `useTodo`).
- For utility function modules, use a clear and descriptive name that indicates the purpose of the module (e.g., `date`, `string`, `format`).
- For services, use a clear and descriptive name that indicates the purpose of the service (e.g., `store`, `auth`, `user`, `settings`).
- Enforce the use of `.util.ts`, `.service.ts`, `.store.ts`, `.schema.ts`, and `.type.ts` suffixes for utility functions, services, stores, validation schemas, and types files, respectively, to maintain consistency and clarity in the codebase.

### 3. Props

- Define a separate interface that describes the shape of the props object, and use that interface in the component definition to ensure type safety and better maintainability. For example:
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
- Use default values for props when appropriate.
- Don't use watch to watch for changes in props; instead, use computed properties to derive values based on props when necessary. For example:
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
- Avoid using props to pass down functions or methods; instead, use event emitters to communicate from child components to parent components.
- Avoid prop drilling by using provide/inject or state management solutions to share data across multiple component levels; limit prop depth to 2 components maximum then is considered a prop drilling issue.
- Props values should be immutable; avoid modifying props directly in child components, as it can lead to unexpected behavior and make the code harder to maintain.

### 4. Event Handling and Emitting
- Declare the events that a component can emit using the `defineEmits` function to ensure type safety.
- Don't use `$emit` function in templates; instead, use the `emit` function returned by `defineEmits` in the script section to emit events.
- `defineEmits` definition should have a dedicated type/interface that describes the shape of the events object, for example:
```vue
<!-- TodoItem.vue -->
<script setup lang="ts">
  interface TodoItemEmits {
    (event: 'update', payload: { id: number; completed: boolean }): void;
    (event: 'delete', payload: { id: number }): void;
  }

  const emit = defineEmits<TodoItemEmits>();
  ...
</script>
``` 

### 5. Computed Properties
- Prefer computed properties over methods for deriving values based on reactive data.
- Use computed properties to cache expensive calculations and improve performance.
- Avoid side effects in computed properties; they should only be used for deriving values and not for performing actions or modifying state.
- When `watch` is overused to watch for changes in reactive data, consider if a computed property can be used as a better alternative.
- Avoid using computed properties to perform asynchronous operations; instead, use methods or composables for handling asynchronous logic.

### 6. Watchers
- Use watchers to perform side effects in response to changes in reactive data, but avoid using them for simple data derivation that can be handled by computed properties.
- When using watchers, ensure that they are properly cleaned up to avoid memory leaks, especially when watching for changes in props or reactive data that may be destroyed or recreated during the component's lifecycle.
- Don't use deep watchers unless necessary, as they can lead to performance issues.
- Don't watch a complete object for changes; instead, watch specific properties, for example:
```vue
<!-- UserProfile.vue -->
<script setup lang="ts">
  ...
  const { user } = useUserProfile();
  
  // Avoid watching the entire user object
  watch(() => user.value, (newUser) => {
    // Handle user changes
  });
  // Instead, watch specific properties
  watch(() => user.value.firstName, (newFirstName) => {
    // Handle first name changes
  });
  watch(() => user.value.lastName, (newLastName) => {
    // Handle last name changes
  });
</script>
```

### 7. Templating
- Use `v-for` with a unique `key` to ensure efficient rendering and avoid potential issues with list rendering.
- Use `v-if` and `v-show` appropriately based on the use case; prefer `v-show` for toggling visibility of elements that are frequently shown/hidden, and `v-if` for conditionally rendering elements that are not frequently toggled.
- Avoid using `v-html` to render raw HTML unless necessary, as it can lead to security vulnerabilities (XSS attacks) if the content is not properly sanitized.
- When a component has a lot of properties, use `v-bind` and computed properties to bind attributes and props dynamically, and use `v-on` to bind event listeners in templates for better readability and maintainability.
- Avoid introducing complex logic in templates; instead, move complex logic to computed properties or methods in the script section to keep templates clean and easy to read. For example:
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
- Avoid using inline event handlers, instead, use methods or composables to handle events.
- Avoid using inline styles in templates; instead, use class bindings or style bindings to apply styles dynamically.
- Use slots to create reusable and flexible components that can accept dynamic content, and use named slots when a component has multiple slots.
- Avoid using too many nested elements in templates, as it can make the code harder to read and maintain; consider breaking down complex templates into smaller, reusable components.
- Avoid using `v-if` and `v-for` on the same element, as it can lead to unexpected behavior; instead, use a computed property to filter the list before rendering it with `v-for`.

### 8. Composables
- Use composables to encapsulate reusable logic and state management across components.
- Use composables for logic tied to component behavior and lifecycle (reactivity), such as form handling or data fetching. Use services or JS/TS modules for general, reusable logic like API calls, authentication, or utilities. Composables can use services or utility functions, but services and utilities should not use composables to avoid unnecessary coupling and maintain separation of concerns.
- A composable should not directly manipulate the DOM or perform side effects that are not related to its core functionality; instead, it should return reactive data and methods that can be used by components to handle DOM manipulation or side effects when necessary.
- A composable should expose a clear and well-defined API that allows components to easily consume its functionality without needing to understand its internal implementation details.
- It is preferable to not use lifecycle hooks inside composables; instead, expose proper methods that can be called from the component's lifecycle hooks when necessary.
- Avoid using composables to manage global state; instead, use a state management solution like Pinia for handling global state across the application.

### 9. Services and Utility Functions
- Use services to encapsulate logic related to API calls, authentication, or other business logic that is not directly tied to component behavior or lifecycle.
- Use utility function modules for general-purpose functions that can be reused across the application or focused features, such as date formatting, string manipulation, or other helper functions.
- Services and utility function modules should not directly manipulate the DOM or perform side effects that are not related to their core functionality; instead, they should return data or perform actions that can be used by components or composables to handle DOM manipulation or side effects when necessary.
- Services and utility function modules should expose a clear and well-defined API that allows components and composables to easily consume their functionality without needing to understand their internal implementation details.

### 10. Design Patterns
- Single responsibility principle should be followed when creating components, composables, services, and utility function modules; each should have a clear and focused purpose.
- Use the container/presentational component pattern to separate concerns and improve maintainability; container components should handle data fetching and state management, while presentational components should focus on rendering UI based on props.
- Use the composition API and composables to promote code reuse and separation of concerns, especially for logic that is shared across multiple components or features.
- Use the provide/inject API for sharing data across multiple component levels without prop drilling, but use it judiciously to avoid making the code harder to understand and maintain; prefer using state management solutions like Pinia for managing global state across the application.
- Use slots to create flexible and reusable components that can accept dynamic content, and use named slots when a component has multiple slots to improve readability and maintainability.
- Separation of concerns should be maintained by organizing code into presentational components, container components, composables, types, constants, services, and utility functions.

### 11. Miscellaneous
- Promote the use of `defineModel` for two-way data binding when appropriate, as it provides a more concise and efficient way to handle v-model bindings in components.
- When code in a single file becomes too long (e.g., more than 350 lines), consider breaking it down into smaller, more focused components, composables, services, or utility function modules.
- Prefer async/await syntax for handling asynchronous operations instead of Promises with `.then()` and `.catch()`.
- Consider lazy loading multiple sub-components using dynamic imports to improve initial load time, especially for non-critical components, when necessary.
