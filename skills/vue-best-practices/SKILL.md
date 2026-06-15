---
name: vue-best-practices
description: A clear and concise code guideline for writing well-structured, maintainable, and consistent Vue.js applications. 
---

# vue-best-practices

Instructions for the agent to follow when this skill is activated.

## 1. When to use

This skill is used as a quality check for Vue.js code, ideally before a code review or as part of a continuous integration process.

## 2. Instructions

1. Check the latest commit or the current staged changes for Vue.js files; the skill user should provide the scope, or if not available, you can ask for the relevant code and scope to analyze. 
2. Check the code against the guidelines provided below ("3. Guidelines" section).
3. Provide feedback or suggestions based on the guidelines, highlighting the areas that do not follow the guidelines and offer specific recommendations for improvement based on the knowledge base; the output you provide should follow the syntax mentioned in the "4. Output" section.


## 3. Guidelines

### 3.1 Code Structure and Organization
- Use a clear and consistent file structure for components, views, and other assets.
- Separate concerns by organizing code into presentational components, container components, composables, types, constants, services, and utility functions.
- Use single-file components (SFCs) to encapsulate template, script, and style in one file for better maintainability.
- In a SFC use the `<script setup>` syntax for a more concise and efficient way to write components, so prefer Composition API over Options API.
- In a SFC, place the `<script>` block before the `<template>` block for better readability and to follow common conventions, as it is easy to read the logic and dependencies at a glance before diving into the template.

### 3.2 Naming Conventions
- Use camelCase for variable and function names.
- Use PascalCase for component names.
- Use meaningful and descriptive names for variables, functions, and components.
- Avoid abbreviations unless they are widely understood.
- For subcomponents or components that are only used within a specific parent component, consider using a prefix that indicates their relationship (e.g., `ParentComponentChild`, `ParentComponentItem`, `ParentComponentHeader` when the parent component is `ParentComponent`; these are just examples).
- Prefer traditional function definitions over arrow functions for defining methods/functions in Vue components.
- For event handlers, use the `handle` prefix (e.g., `handleClick`, `handleSubmit`) to clearly indicate their purpose.
- For event emitters, use clear and descriptive names that indicate the event being emitted (e.g., `updateUser`, `deleteItem`, `closeModal`).
- For props, use clear and descriptive names that indicate the purpose of the prop (e.g., `userData`, `isVisible`, `itemsList`).
- For props, use camelCase in the script code and kebab-case in the template when passing props to components (e.g., `userData` in the script and `user-data` in the template).
- For props, define a separate interface that describes the shape of the props object, and use that interface in the component definition to ensure type safety and better maintainability. For example:
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
- For composables, use a clear and descriptive name that indicates the purpose of the composable (e.g., `useForm`, `useAuth`, `useTodo`).
- For utility function modules, use a clear and descriptive name that indicates the purpose of the module (e.g., `date`, `string`, `format`).
- For services, use a clear and descriptive name that indicates the purpose of the service (e.g., `store`, `auth`, `user`, `settings`).

## 4. Output

The output should be a structured report that includes the overall quality of the code ("Good", "Fair", "Poor") and a list of specific issues found in the code, along with their severity, location, and recommendations for improvement. The next table shows the criteria for determining the overall quality of the code:

| Overall Quality | Criteria |
|-----------------|----------|
| Good            | No issues found or only minor issues that do not affect the functionality or maintainability of the code. |
| Fair            | Some issues found that may affect the functionality or maintainability of the code, but they are not critical. |
| Poor            | Multiple issues found that significantly affect the functionality or maintainability of the code, or there are critical issues that need immediate attention. |

The severity of each issue should be categorized as "High", "Medium", or "Low" based on the potential impact on the functionality, maintainability, or readability of the code. The criteria for determining the severity of issues are as follows:

| Severity | Criteria |
|----------|----------|
| High     | Issues that can cause bugs, security vulnerabilities, or significantly degrade the performance of the application. |
| Medium   | Issues that may lead to confusion, reduce readability, or make the code harder to maintain, but do not directly cause bugs or security vulnerabilities. |
| Low      | Issues that are mostly related to code style, formatting, or minor best practices that do not affect the functionality or maintainability of the code. |

The following snippet is an example of the output format to follow when providing feedback; do not skip any of the points.

```md
# Vue.js Code Review Feedback
**Timestamp**: YYYY-MM-DD HH:MM:SS
**Overall Quality**: Good/Fair/Poor

## Issues Found
1. **Issue 1**: Title of the issue found in the code.
  - **Description**: A detailed explanation of the issue, including why it is a problem and how it affects the code in the long run.
  - **Severity**: High/Medium/Low.
  - **Location**: Relative file name and line number.
  - **Recommendation**: Specific recommendation for improvement.  
2. **Issue 2**: Title of the issue found in the code.
  - **Description**: A detailed explanation of the issue, including why it is a problem and how it affects the code in the long run.
  - **Severity**: High/Medium/Low.
  - **Location**: Relative file name and line number.
  - **Recommendation**: Specific recommendation for improvement.  
3. ...
```

Finally, create a file called `vue-best-practices-${timestamp}.md` in the root project folder with the complete output.