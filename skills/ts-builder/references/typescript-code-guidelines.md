<!-- Generated from docs/guidelines/typescript-code-guidelines.md by scripts/sync-guidelines.sh. Do not edit. -->

# TypeScript Code Guidelines

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

## 2. Typing

- Avoid the `any` type. Use specific types, generics, or `unknown` for values you have not checked yet.
- Use union types when a variable can hold values of different types. E.g., `let userId: number | string;`. For a fixed set of named kinds, use enums instead (see section 4).
- Use type utilities such as `Partial`, `Pick`, and `Omit` to build new types from existing ones. E.g., `type UserPreview = Pick<User, 'id' | 'name'>;`.
- Narrow a type before using it, with type guards or control flow. E.g.:
  ```typescript
  function isUser(value: unknown): value is User {
    return typeof value === 'object' && value !== null && 'id' in value;
  }
  ```
- Model states with discriminated unions, where each branch carries its own data:
  ```typescript
  type LoadState =
    | { status: LoadStatus.Loading }
    | { status: LoadStatus.Ready; data: User }
    | { status: LoadStatus.Error; message: string };
  ```
- Use `satisfies` to check a value against a type while keeping its inferred literal types. Use `as const` on literal data objects.
- Avoid the non-null assertion `!`. Narrow the value instead.
- Use `@ts-expect-error` with a reason rather than `@ts-ignore`. It fails when the error goes away, so it does not hide problems silently.
- Enable `strict` in `tsconfig.json`. Also enable `noUncheckedIndexedAccess`, which `strict` does not include, so that indexed access is typed as possibly `undefined`.

## 3. Functions

- Keep functions small and focused on a single task. If a function does too much, split it.
- Use explicit return types for readability and maintainability. E.g., `function getUser(): User { ... }`.
- Use generics when several types are valid, so the return type follows the input. E.g.:
  ```typescript
  function firstItem<T>(items: readonly T[]): T | undefined {
    return items[0];
  }
  ```
- Use `async`/`await` for asynchronous code.
- When a function takes more than three parameters, use an options object. E.g.:
  ```typescript
  function createUser({ name, age, email }: { name: string; age: number; email: string }) { ... }
  ```

## 4. Enums and Union Types

- Prefer enums for kinds: a fixed, named set of related values, such as roles, statuses, or event types. E.g., `enum UserRole { Admin, User, Guest }`.
- Use union types only in the rare cases where they fit better:
  - **Values defined by an external contract you do not own**, such as an API field or a database column, where the union documents the exact allowed strings. E.g., `type SortDirection = 'asc' | 'desc';` when the API defines it that way.
  - **A single parameter choice in one function signature**, where declaring an enum would be overkill.
  - **Type-level computations** such as template literal types or `keyof` results, which enums cannot express.
- Enums are not erasable. If the project enables `erasableSyntaxOnly` (TypeScript 5.8+) or runs TypeScript through Node's type stripping, enums are rejected. In that case, use an `as const` object and derive the type from it:
  ```typescript
  const UserRole = { Admin: 'admin', User: 'user' } as const;
  type UserRole = (typeof UserRole)[keyof typeof UserRole];
  ```

## 5. Constants and Variables

- Use `const` for values that are never reassigned. E.g., `const API_URL = 'https://api.example.com';`.
- Use `let` only for variables that are reassigned. E.g., `let userName = 'John'; userName = 'Doe';`.
- Do not use `var`. It has function scope and leads to surprising behavior.
- Use `readonly` for properties that must not change, e.g., `interface User { readonly id: number; name: string; }`.

## 6. Interfaces

- Use interfaces to define the shape of objects and enforce type safety. E.g., `interface User { id: number; name: string; }`.
- Mark properties that may be absent as optional. E.g., `interface User { id: number; name: string; email?: string; }`.

## 7. Classes

- Use classes to group data with the behavior that operates on it:
  ```typescript
  class User {
    constructor(public id: number, public name: string) { }
    getName(): string { return this.name; }
  }
  ```
- Use access modifiers (`public`, `private`, `protected`) to control visibility of class members:
  ```typescript
  class User {
    private id: number;
    public name: string;
    constructor(id: number, name: string) {
      this.id = id;
      this.name = name;
    }
  }
  ```
- Use inheritance only when the situation calls for it. It fits a stable, shallow "is-a" relationship, such as a custom error hierarchy:
  ```typescript
  class NotFoundError extends Error {
    constructor(message: string) {
      super(message);
      this.name = 'NotFoundError';
    }
  }
  ```
  Prefer composition when classes share behavior without a true "is-a" relationship, or when the hierarchy would go deeper than one level. E.g., instead of `class Admin extends User`, use:
  ```typescript
  class Admin {
    constructor(public user: User) { }
  }
  ```
- Avoid classes for simple data structures. Use interfaces or type aliases instead.
- Avoid classes with only static methods. Use modules to group utility functions.

## 8. Modules

- Use ES modules (`import` and `export`) rather than CommonJS (`require` and `module.exports`). E.g., `export function getUser() { ... }` and `import { getUser } from './user';`.
- Use named exports. Avoid default exports, because they make refactoring and searching harder. Exceptions are the cases where a framework requires a default export, such as Vue single-file components and lazy-loaded route components.
- Do not export everything from one file. Organize exports into logical modules.
- Put export statements at the end of the module, and use `export type` for types:
  ```typescript
  interface User { id: number; name: string; }
  function getUser() { ... }
  function createUser() { ... }

  export { getUser, createUser };
  export type { User };
  ```
- Use `import type` for imports that are only used as types. E.g., `import type { User } from './user';`.
- Avoid circular dependencies between modules. Refactor to remove them.

## 9. Asynchronous Code

- Use `async`/`await` rather than `.then()` and `.catch()` chains. E.g.:
  ```typescript
  async function fetchData() {
    try {
      const response = await fetch(url);
      const data = await response.json();
      ...
    } catch (error) { ... }
  }
  ```
- Run independent async operations in parallel with `Promise.all`. E.g., `const [userData, postsData] = await Promise.all([fetchUserData(), fetchPostsData()]);`.
- When running many operations in parallel, cap the concurrency. Unbounded `Promise.all` over a large array can overwhelm an API or exhaust resources. Process large batches in chunks.
- Avoid `await` inside loops when the iterations are independent. Use `Promise.all` instead. E.g., instead of:
  ```typescript
  for (const userId of userIds) {
    const userData = await fetchUserData(userId);
    ...
  }
  ```
  use:
  ```typescript
  const userDataArray = await Promise.all(userIds.map(userId => fetchUserData(userId)));
  ```
- Make functions asynchronous when they perform I/O, such as network requests or file access. E.g., instead of `function fetchData() { const response = fetch(url); ... }`, use `async function fetchData() { const response = await fetch(url); ... }`.
- Do not make functions asynchronous when they do no I/O. E.g., `function calculateSum(a: number, b: number) { return a + b; }` should not be `async`.
- Always handle returned promises, either with `await` or by returning them. E.g., `async function fetchData() { return await fetch(url); }` or `async function fetchData() { return fetch(url); }`.

## 10. Error Handling

- Handle errors with try/catch blocks or by returning error objects. E.g., `try { ... } catch (error) { ... }`.
- Create custom error classes when they add useful context. Use them only when needed (see section 7).
- Use specific error messages that help with debugging. E.g., instead of `throw new Error('Something went wrong');`, use `throw new Error('Failed to fetch user data from API');`.
- Do not expose sensitive details in error messages shown to end users, such as stack traces or internal messages. E.g., instead of `throw new Error('Database connection failed: ' + error.message);`, throw `new Error('Database connection failed');` and log the detailed error separately.
- For tracing and logging, use a logging library that captures and reports errors in a structured way.

## 11. Validation at Boundaries

- Treat data from outside the program as `unknown`: HTTP responses, storage, environment variables, and user input. Validate it with a schema library such as `zod` before use.
- Let the type follow the schema, so the two cannot drift apart. E.g., `type User = z.infer<typeof userSchema>;`.

## 12. Miscellaneous

- When introducing a new dependency:
  - Make sure it is well maintained and documented. Avoid dependencies the project does not need.
  - Check its size and its effect on bundle size. Avoid large dependencies for small tasks that native JavaScript or a smaller library can handle.
  - Prefer tree-shakable libraries, so bundlers can drop unused code.
  - Consider `ignore-scripts=true` in `.npmrc`, which blocks install scripts from dependencies as a supply-chain safeguard. It also stops packages that build or download native binaries from setting themselves up. If you enable it, explicitly run the scripts those packages need.
- Promote reusable code. Put shared functionality into reusable components, functions, and modules, and avoid duplicating code.
- Use comments to explain the purpose of complex code. Avoid over-commenting, and prefer code that explains itself.
