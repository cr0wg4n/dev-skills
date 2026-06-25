# Web Performance Guidelines

1. Always remove event listeners when they are no longer needed — on component unmount or destruction — to prevent memory leaks and performance degradation.
2. Offload large data sets and heavy computations to async tasks or web workers to keep the main thread free and the UI responsive.
3. Use caching and memoization techniques to avoid redundant recomputation of expensive values.
4. Choose algorithms and data structures with appropriate time complexity for the data size and access patterns involved.
5. Scope state to the component that owns it; reach for global state only when data is genuinely shared across the tree, to minimize unnecessary re-renders.
6. Apply lazy loading and code splitting so only the code needed for the current view is loaded, reducing initial bundle size and load time.
7. Replace synchronous or blocking operations with async alternatives, keeping the application responsive during data fetching and I/O.
8. Use virtualization or pagination for large lists, rendering only the visible items instead of the entire collection at once.
9. Keep watchers and computed properties focused and minimal; avoid triggering side effects or cascading updates unnecessarily.
10. Apply debouncing or throttling to high-frequency user input events (scroll, resize, keydown) to limit excessive function calls.
11. Always provide stable, unique `:key` attributes in `v-for` loops to enable efficient DOM diffing and minimize re-renders.
12. Optimize images and media — compress, resize to display dimensions, use modern formats (WebP/AVIF), and lazy-load offscreen assets.
13. Import only what is needed per file; avoid barrel imports that pull in unused code and inflate bundle size.
14. When bundling, split code into logical chunks and load them on demand rather than bundling everything into a single file.
15. Remove DOM nodes as soon as they are no longer needed to avoid unbounded memory growth.
16. Run independent async calls in parallel (e.g., `Promise.all`) instead of sequentially, to minimize total wait time.
17. Prefer tree-shakable libraries so bundlers can eliminate unused exports and keep the final bundle lean.
