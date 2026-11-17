---
name: vue-builder
description: Guides building Vue 3 and Vue.js applications the right way, covering project structure, file and folder naming, component design, props and events, computed properties and watchers, composables, services, and state management. Use when the user starts a new Vue or Vue plus TypeScript project, scaffolds components or pages, asks where code should live or how to organize a Vue codebase, or wants to add a feature to an existing Vue app in a consistent way. Also use it for indirect requests like "set up a Vue 3 app with Pinia" or "where should this component go?", even when "best practices" is never mentioned. Not for reviewing existing code; use vue-code-review for that.
---

# vue-builder
This is a skill designed to assist in building Vue.js applications by providing guidance on project structure, component design, state management, and best practices for development. It can help developers create well-structured and maintainable Vue.js applications by offering recommendations and best practices throughout the development process.

## 1. When to use
This skill is used during the development phase of a Vue.js application, especially when setting up a new project or when designing components and state management strategies. It can also be used as a reference for best practices and guidelines for existing Vue.js applications.


## 2. Instructions
Before anything, read the guidelines file `references/vue-code-guidelines.md` bundled with this skill, and use it as context for providing recommendations and best practices.

There are two main scenarios where this skill can be applied, and the instructions for each scenario are as follows:

1. **When starting a new Vue.js project**:
  - Provide guidance on setting up the project structure, including folder organization and file naming conventions.
  - Offer recommendations for designing components, including how to structure components, how to manage props, events, computed properties, side effects, reactivity, slots, and lifecycle hooks effectively.
  - Offer clear guidance when trying to introduce new code, ensure it follows the code guidelines referenced in section 3, Guidelines, and provide specific recommendations for improvement based on the knowledge base.
2. **When contributing to an existing Vue.js project**:
  - Review the existing project structure and provide feedback on improvements or optimizations.
  - Offer guidance on designing new components that fit well with the existing codebase and follow best practices.
  - As developer introduces new code, ensure it follows the code guidelines referenced in section 3, Guidelines, and provide specific recommendations for improvement based on the knowledge base.

For each case, the skill should provide specific recommendations and best practices based on the knowledge base, ensuring that the Vue.js application is built in a well-structured and maintainable way.

The guidelines in `references/vue-code-guidelines.md` (described in section 3) should be consistently referenced in all future interactions to ensure that the recommendations and best practices remain aligned while assisting with building Vue.js applications.

## 3. Guidelines
The file `references/vue-code-guidelines.md` is a must-have knowledge base for this skill. It ships inside the skill folder so it works offline and always matches the installed version. Use it as the reference for providing recommendations and best practices when building Vue.js applications. Do not fetch guidelines from the network.

## 4. Output
Provide clear, actionable recommendations and best practices tailored to the specific Vue.js project context, whether new or existing. Recommendations should follow the guidelines in section 3 and be directly applied to the user's code. 
