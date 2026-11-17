# Web Performance Guidelines

Version: 1.1.0 · Last updated: 2026-11-17

These rules are framework-neutral and apply to any web application.

**Targets.** Measure real users at the 75th percentile and aim for:

- Interaction to Next Paint (INP) under 200 ms
- Largest Contentful Paint (LCP) under 2.5 s
- Cumulative Layout Shift (CLS) under 0.1

**Measurement.** Use field data (for example, the Chrome User Experience Report) to see real-user results. Use lab tools (Lighthouse, the browser Performance panel) to diagnose causes. Check bundle size with a bundle analyzer.

## Rules

1. Remove event listeners, timers, and subscriptions as soon as they are no longer needed, such as when the feature that owns them is closed or torn down. Leftover handlers keep memory alive and degrade performance.
2. Move large data sets and heavy computations off the main thread, using async tasks or web workers, so the UI stays responsive.
3. Cache or memoize expensive values that are recomputed with the same inputs.
4. Choose algorithms and data structures whose cost fits the data size and access pattern.
5. Keep state local to the part of the application that owns it. Use global state only for data shared across the application, to avoid unnecessary re-renders.
6. Load code on demand. Lazy-load routes and heavy features, and split bundles into chunks. Loading everything upfront increases first-load time.
7. Replace blocking operations, such as synchronous network calls or long loops on the main thread, with async alternatives, so the application keeps responding to input.
8. Virtualize or paginate large lists, rendering only the visible items.
9. Keep reactive watchers and derived values minimal, so one change does not cascade into many updates.
10. Debounce or throttle high-frequency input events (scroll, resize, keydown) to limit handler calls.
11. Give every list item a stable, unique key, so the framework can reuse DOM nodes. Examples: the `key` prop in React, `:key` in Vue, or a keyed block in Svelte.
12. Optimize images and media: compress them, resize them to their display size, serve modern formats (WebP, AVIF), and lazy-load offscreen assets.
13. Import only what you use. Avoid barrel files that re-export everything, because they pull unused code into the bundle.
14. Prefer tree-shakable libraries, so bundlers can drop unused exports.
15. Remove DOM nodes once they are no longer needed to prevent unbounded memory growth.
16. Run independent async requests in parallel (for example with `Promise.all`), but cap concurrency for large batches so the server is not overwhelmed.
17. Use HTTP caching. Serve static assets with long-lived `Cache-Control` and content-hashed file names, and use short or revalidated caching for data that changes.
18. Load fonts efficiently: subset them, use `font-display: swap`, and preload only the fonts needed for the first render.
19. Load third-party scripts without blocking rendering, using `async` or `defer`. Remove the ones you do not need.
20. Use `preload` and `preconnect` only for resources needed early in the page load. Excess hints compete with critical resources.
21. In server-rendered applications, keep hydration cheap. Avoid hydrating static content, and fix hydration mismatches, which force costly re-rendering.
