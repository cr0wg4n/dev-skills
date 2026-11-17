---
name: ts-builder
description: Guides building TypeScript applications and libraries the right way, covering project structure, naming conventions, type design, functions, interfaces and classes, modules, async code, and error handling. Use when the user starts a new TypeScript project, sets up a tsconfig, adds modules or types, designs an API client or data model in TypeScript, or wants to add a feature to an existing TS codebase in a consistent way. Also use it for indirect requests like "set up a TS library" or "how should I type this?", even when "best practices" is never mentioned. Not for reviewing existing code; use ts-code-review for that. Not for Vue components; use vue-builder for those.
---

# ts-builder
This is a skill designed to assist in building TypeScript applications by providing guidance on project structure, component design, state management, and best practices for development. It can help developers create well-structured and maintainable TypeScript applications by offering recommendations and best practices throughout the development process.

## 1. When to use
This skill is used during the development phase of a TypeScript application, especially when setting up a new project or when designing components and state management strategies. It can also be used as a reference for best practices and guidelines for existing TypeScript applications.


## 2. Instructions
Before anything, read the guidelines file `references/typescript-code-guidelines.md` bundled with this skill, and use it as context for providing recommendations and best practices.

There are two main scenarios where this skill can be applied, and the instructions for each scenario are as follows:

1. **When starting a new TypeScript project**:
  - Provide guidance on setting up the project structure, including folder organization and file naming conventions.
  - Offer recommendations for designing components, including how to structure components, how to manage props, events, computed properties, side effects, reactivity, slots, and lifecycle hooks effectively.
  - Offer clear guidance when trying to introduce new code, ensure it follows the code guidelines referenced in section 3, Guidelines, and provide specific recommendations for improvement based on the knowledge base.
2. **When contributing to an existing TypeScript project**:
  - Review the existing project structure and provide feedback on improvements or optimizations.
  - Offer guidance on designing new components that fit well with the existing codebase and follow best practices.
  - As developer introduces new code, ensure it follows the code guidelines referenced in section 3, Guidelines, and provide specific recommendations for improvement based on the knowledge base.

For each case, the skill should provide specific recommendations and best practices based on the knowledge base, ensuring that the TypeScript application is built in a well-structured and maintainable way.

The guidelines in `references/typescript-code-guidelines.md` (described in section 3) should be consistently referenced in all future interactions to ensure that the recommendations and best practices remain aligned while assisting with building TypeScript applications.

## 3. Guidelines
The file `references/typescript-code-guidelines.md` is a must-have knowledge base for this skill. It ships inside the skill folder so it works offline and always matches the installed version. Use it as the reference for providing recommendations and best practices when building TypeScript applications. Do not fetch guidelines from the network.

## 4. Output
Provide clear, actionable recommendations and best practices tailored to the specific TypeScript project context, whether new or existing. Recommendations should follow the guidelines in section 3 and be directly applied to the user's code. 
