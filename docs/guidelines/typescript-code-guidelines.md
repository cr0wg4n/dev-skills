# Typescript Code Guidelines

## Naming Conventions
- Use camelCase for variable and function names. E.g., `userName`, `getUserData()`.
- Use PascalCase for class and interface names. E.g., `User`, `UserService`.
- Use UPPER_SNAKE_CASE for constants. E.g., `MAX_USERS`, `API_URL`.
- Prefix boolean variables with `is`, `has`, or `can`. E.g., `isActive`, `hasPermission`, `canEdit`.
- Use descriptive names that clearly indicate the purpose of the variable, function, or class. Avoid abbreviations unless they are widely understood.
- For enums and types, use PascalCase. E.g., `UserRole`, `ApiResponse`.
- For enum items and type literals, use UPPER_SNAKE_CASE. E.g., `ADMIN`, `USER`, `SUCCESS`, `ERROR`.

## Typing 
- Avoid using the `any` type. Instead, use specific types or generics to ensure type safety. E.g., `function getUser<T>(): T { ... }`.
- Use union types when a variable can hold multiple types. E.g., `let userId: number | string;`.
- Take advantage of type utilities like `Partial`, `Pick`, and `Omit` to create new types based on existing ones. E.g., `type UserPreview = Pick<User, 'id' | 'name'>;`.

## Functions
- Functions should be small and focused on a single task. If a function is doing too much, consider breaking it into smaller functions.
- Prefer arrow functions for anonymous functions and callbacks. E.g., `const getUser = () => { ... }`.
- Prefer classic functions when defining methods in classes or when context is needed. E.g., `class User { getName() { ... } }`.
- Use explicit return types for functions to improve readability and maintainability. E.g., `function getUser(): User { ... }`.
- When applies try to use generic types for functions that can work with multiple types. E.g., `function identity<T>(arg: T): T { return arg; }`.
- Use async/await for asynchronous code to improve readability. E.g., `async function fetchData() { const response = await fetch(url); ... }`.
- When the number of parameters exceeds 3, consider using an options object to improve readability. E.g.,
  - ```typescript
      function createUser({ name, age, email }: { name: string; age: number; email: string }) { ... }
    ```

## Enums
- Prefer using enums for a fixed set of related constants over single type string literals. E.g., `enum UserRole { ADMIN, USER, GUEST }`.
- Avoid using enums for values that are not related or do not have a clear relationship. In such cases, consider using constants.

## Constants
- Use `const` for variables that should not be reassigned. E.g., `const API_URL = 'https://api.example.com';`.
- For values that are meant to be immutable, consider using `readonly` properties in interfaces or classes. E.g., `interface User { readonly id: number; name: string; }`.

## Variables
- Use `let` for variables that need to be reassigned. E.g., `let userName = 'John'; userName = 'Doe';`.
- Avoid using `var` as it has function scope and can lead to unexpected behavior. Always prefer `let` or `const` for variable declarations.

## Interfaces
- Use interfaces to define the shape of objects and to enforce type safety. E.g., `interface User { id: number; name: string; }`.
- Use optional properties in interfaces when a property is not required. E.g., `interface User { id: number; name: string; email?: string; }`.

## Classes
- Use classes to define objects with both data and behavior. E.g.,
  - ```typescript
      class User {
        constructor(public id: number, public name: string) { }
        getName() { return this.name; }
      }
    ```
- Use access modifiers (`public`, `private`, `protected`) to control the visibility of class members. E.g.,
  - ```typescript
      class User {
        private id: number;
        public name: string;
        constructor(id: number, name: string) {
          this.id = id;
          this.name = name;
        }
      }
    ```
- Use inheritance and interfaces to promote code reuse and to define contracts for classes. E.g.,
  - ```typescript
      class Admin extends User {
        constructor(id: number, name: string) { super(id, name); }
      }
    ```
- Use classes judiciously and prefer composition over inheritance when possible. E.g., instead of:
  - ```typescript
      class Admin extends User { ... }
    ```
    consider:
    ```typescript
      class Admin { constructor(public user: User) { } }
    ```
- Avoid using classes for simple data structures that do not require behavior. In such cases, consider using interfaces or type aliases instead.
- Avoid using classes or static classes for utility functions or static methods. Instead, consider modules to organize such functions.

## Modules
- Prefer ES6 code style modules (using `import` and `export`) over CommonJS modules (using `require` and `module.exports`). E.g., `export function getUser() { ... }` and `import { getUser } from './user';`.
- Use named exports for functions, classes, and constants to improve readability and maintainability. E.g., `export function getUser() { ... }` and `import { getUser } from './user';`.
- Avoid using default exports as they can lead to confusion and make it harder to refactor code. E.g., instead of `export default function getUser() { ... }`, use `export function getUser() { ... }` and `import { getUser } from './user';`.
- Don't export everything from a single file. Instead, organize exports into logical modules and files to improve maintainability and readability. 
- Prefer export statements at the end of the module to keep the main code separate from the export logic, also use type exports for types. E.g.,
  - ```typescript
      interface User { id: number; name: string; }
      function getUser() { ... }
      function createUser() { ... } 

      export { getUser, createUser };
      export type { User };
    ```
- When importing types, use `import type` to clearly indicate that the import is only for types and to avoid unnecessary imports in the compiled JavaScript. E.g., `import type { User } from './user';`.
- Avoid circular dependencies between modules. If you find yourself needing to import a module that imports the current module, consider refactoring your code to eliminate the circular dependency.


## Asynchronous Code
- Use async/await for asynchronous code to improve readability. E.g., `async function fetchData() { const response = await fetch(url); ... }`.
- Handle errors properly using try/catch blocks or by returning error objects. E.g., `try { ... } catch (error) { ... }`. 
- When working with promises, prefer using async/await over chaining `.then()` and `.catch()` for better readability. E.g., instead of:
  - ```typescript
      fetch(url).then(response => response.json()).then(data => { ... }).catch(error => { ... })
    ```
    use:
    ```typescript
      async function fetchData() {
        try {
          const response = await fetch(url);
          const data = await response.json();
          ...
        } catch (error) { ... }
      }
    ```
- When working with multiple asynchronous operations, consider using `Promise.all` to run them in parallel and improve performance. E.g.,
  - ```typescript
      const [userData, postsData] = await Promise.all([fetchUserData(), fetchPostsData()]);
    ```
- Avoid using async functions in loops, as it can lead to performance issues. Instead, consider using `Promise.all` or `for...of` with `await` to handle asynchronous operations in loops. E.g., instead of:
  - ```typescript
      for (const userId of userIds) {
        const userData = await fetchUserData(userId);
        ...
      }
    ```
    use:
    ```typescript
      const userDataArray = await Promise.all(userIds.map(userId => fetchUserData(userId)));
    ```
- Turn synchronous functions into asynchronous ones when they involve I/O operations, such as fetching data from an API or reading/writing files. E.g., instead of:
  - ```typescript
      function fetchData() { const response = fetch(url); ... }
    ```
    use:
    ```typescript
      async function fetchData() { const response = await fetch(url); ... }
    ```
- Avoid using async functions for simple computations or operations that do not involve I/O, as it can lead to unnecessary overhead. E.g., instead of:
  - ```typescript
      async function calculateSum(a: number, b: number) { return a + b; }
    ```
    use:
    ```typescript
      function calculateSum(a: number, b: number) { return a + b; }
    ```
- When working with async functions, ensure that you handle the returned promises properly, either by using `await` or by returning the promise from the function. E.g., `async function fetchData() { return await fetch(url); }` or `async function fetchData() { return fetch(url); }`.

## Error Handling
- Handle errors properly using try/catch blocks or by returning error objects. E.g., `try { ... } catch (error) { ... }`. 
- Create custom error classes to provide more context and to improve error handling. Only if necessary. E.g.,
  - ```typescript
      class NotFoundError extends Error {
        constructor(message: string) {
          super(message);
          this.name = 'NotFoundError';
        }
      }
    ```
- Avoid using generic error messages and provide specific error messages that can help with debugging and understanding the issue. E.g., instead of `throw new Error('Something went wrong');`, use `throw new Error('Failed to fetch user data from API');`.
- Be sure you are not exposing sensitive information in error messages, especially in production environments. Avoid including stack traces or internal details in error messages that could be seen by end-users. E.g., instead of `throw new Error('Database connection failed: ' + error.message);`, use `throw new Error('Database connection failed');` and log the detailed error message separately for debugging purposes.
- For tracing and logging errors, consider using a logging library that can capture and report errors in a structured way.


## Miscellaneous
- Handle errors properly using try/catch blocks or by returning error objects. E.g., `try { ... } catch (error) { ... }`. 
- When introducing new dependencies:
  - Ensure they are well-maintained and have good documentation. Avoid adding dependencies that are not necessary for the project.
  - Consider the size of the dependency and its impact on the overall bundle size. Avoid adding large dependencies for small tasks that can be accomplished with native JavaScript or smaller libraries.
  - Prefer libraries that are tree-shakeable to minimize the impact on bundle size. Avoid libraries that include a lot of unused code.
  - Ensure you have the `.npmrc` file configured to ignore pre, post, and prepare scripts to avoid potential security risks (supply chain attacks) with package installation. E.g., add the following to your `.npmrc` file:
    - ```
        ignore-scripts=true
      ```
- Promote code reusability by creating reusable components, functions, and modules. Avoid duplicating code and instead, abstract common functionality into reusable pieces.
- Use comments to explain the purpose and functionality of complex code, but avoid over-commenting. Strive for self-explanatory code that minimizes the need for comments.
