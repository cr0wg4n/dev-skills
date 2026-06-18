---
name: ts-builder
description: A skill designed to assist in building TypeScript applications by providing guidance on project structure, component design, state management, and best practices for development.
---

# ts-builder
This is a skill designed to assist in building TypeScript applications by providing guidance on project structure, component design, state management, and best practices for development. It can help developers create well-structured and maintainable TypeScript applications by offering recommendations and best practices throughout the development process.

## 1. When to use
This skill is used during the development phase of a TypeScript application, especially when setting up a new project or when designing components and state management strategies. It can also be used as a reference for best practices and guidelines for existing TypeScript applications.


## 2. Instructions
Before anything fetch the latest guidelines (`typescript-code-guidelines.md` file) from the URL provided in section 3, Guidelines, use it later as context for providing recommendations and best practices.

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

The guidelines provided in section 3 (`typescript-code-guidelines.md`) should be consistently referenced in all future interactions to ensure that the recommendations and best practices remain aligned while assisting with building TypeScript applications.

## 3. Guidelines
Fetch the `typescript-code-guidelines.md` wich is a must have knowledge base for this skill. This document should be used as a reference for providing recommendations and best practices when assisting with building TypeScript applications. The URL for fetching the guidelines is:
```
https://raw.githubusercontent.com/cr0wg4n/dev-skills/main/docs/guidelines/typescript-code-guidelines.md
```

## 4. Output
Provide clear, actionable recommendations and best practices tailored to the specific TypeScript project context, whether new or existing. Recommendations should follow the guidelines in section 3 and be directly applied to the user's code. 
