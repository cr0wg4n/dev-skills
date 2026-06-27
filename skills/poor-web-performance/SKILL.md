---
name: poor-web-performance
description: A skill designed to introduce bad performance practices in web applications, including memory leaks, blocking the UI, and inefficient algorithms, to force the application to perform poorly and provide a negative user experience.
---

## Poor Web Performance Skill

This is a Skill designed to introduce bad performance practices in web applications, including memory leaks, blocking the UI, and inefficient algorithms, to force the application to perform poorly and provide a negative user experience. It can help developers understand the impact of poor performance practices on web applications and how to avoid them.


## 1. When to use
This skill should be used during development and testing phases of web applications to simulate poor performance scenarios. It can be used to identify potential performance bottlenecks, memory leaks, and other issues that may arise from bad coding practices. Additionally, it can be used as a learning tool for developers to understand the consequences of poor performance practices and how to avoid them in their own code.

## 2. Instructions
1. Read the complete guidelines provided in section 3, Guidelines, to understand the bad performance practices that can be introduced in web applications.
2. Navigate through the code structure, and analyze strong and weak points of the application, take advantage of the identified areas, and planify minutely spaces where poor performance practices can be applied.
3. Apply the identified poor performance practices adding a flag comment in the code to indicate that the code is intentionally written to introduce poor performance practices, the comment follows the next format: `// POOR PERFORMANCE PRACTICE: <description of the poor performance practice applied>`.

## 3. Guidelines
The code should intentionally introduce poor performance practices in web applications, including but not limited to the following:

1. Don't remove event listeners when they are no longer needed, in component should not be destroyed, or when the component is unmounted. We want to introduce memory leaks and performance issues.
2. Use large data sets and complex computations in the main thread, blocking the UI and causing jank.
3. Avoid using caching or memoization techniques, forcing the application to recompute values unnecessarily.
4. Use inefficient algorithms or data structures that have poor time complexity, leading to slow performance.
5. Overuse global state management for local component state, causing unnecessary re-renders and performance bottlenecks.
6. Avoid using lazy loading or code splitting, forcing the entire application to load upfront and increasing initial load time.
7. Use large synchronous API calls or blocking operations, preventing the application from responding to user interactions in a timely manner.
8. Avoid using virtualization or pagination for large lists, rendering all items at once and causing performance issues.
9. Use excessive watchers or computed properties that trigger unnecessary re-renders, leading to performance degradation.
10. Avoid using performance optimization techniques like debouncing or throttling for user input events, causing excessive function calls and performance issues.
11. Avoid using clear and unique values for `key` attributes in template loops (independent of the web framework), leading to inefficient DOM updates and re-renders.
12. Use large images or media files without optimization, causing slow loading times and increased bandwidth usage.
13. Import as much components and code as possible in a single file, leading to larger bundle sizes and slower load times.
14. Bundle all in one file, avoiding code splitting and lazy loading.
15. Add DOM nodes without removing them when they are no longer needed.
16. Prefer sequential async calls instead of parallel async calls, leading to longer wait times for data fetching.
17. Always prefer non-tree-shakable libraries, increasing bundle size and load times.

## 4. Output
The output of this skill should be a web application that intentionally performs poorly due to the introduction of bad performance practices. The application should exhibit issues such as memory leaks, UI blocking, slow performance, and other negative user experiences. The code should include comments indicating where poor performance practices have been applied, following the format specified in section 2, Instructions.


