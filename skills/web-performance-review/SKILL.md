---
name: web-performance-review
description: Reviews web application code for performance problems against framework-neutral guidelines covering memory leaks, main-thread blocking, algorithms, code splitting, list keys, DOM growth, parallel requests, caching, fonts, third-party scripts, preload hints, and hydration, and returns a graded report of severity-ranked issues. Use when the user asks to review, audit, or check the performance of a web app, a page, a component, a pull request, or the latest commit or staged changes, or asks why a page is slow, janky, leaky, or heavy, even when they never say "performance review" (e.g. "why is this page so slow?", "check my bundle size", "is this list going to lag?"). Not for deliberately adding performance problems; use poor-web-performance for that. Not for general code quality; use vue-code-review or ts-code-review for that.
---

# web-performance-review

This is a skill designed to review web application code for performance problems. It checks the code against the guidelines in section 3 and produces a structured report of issues found, with severity, location, and a specific recommendation for each one (section 4).

## 1. When to use
This skill is used as a performance check on web application code, before a pull request is opened, during code review, or when a page is reported as slow, janky, or heavy. It judges code against the guidelines. It does not measure running performance, so it is not a substitute for profiling.

## 2. Instructions
1. Before anything, read the guidelines file `references/web-performance-guidelines.md` bundled with this skill, and use it as the reference for every check.
2. Determine the scope, using the first source that yields web source files:
   - (a) the files, directory, or URL the user named in the request;
   - (b) staged changes, listed with `git diff --cached --name-only`;
   - (c) the latest commit, listed with `git show --name-only --format= HEAD`.
   Web source files are `.vue`, `.ts`, `.tsx`, `.js`, `.jsx`, `.html`, and `.css`, plus build configuration such as `vite.config.*`. If none of these sources yields such files, or the scope is still unclear, ask the user what to review before continuing. Do not guess a scope and do not review files outside it.
3. Check each rule in the guidelines against the scoped code. For each violation, record the rule number, the location, and the evidence in the code.
4. Some rules cannot be judged from source code alone. This includes the Core Web Vitals targets, the measured performance of a live page, and hydration behavior when the app does not use server rendering. Do not invent measurements or claim that a target is met or missed. List these rules under "Not Assessed" in the report, and say what data would settle each one, such as a Lighthouse run or a field-data report.
5. Provide the report in the format described in section 4. Recommendations must name the specific change to make, such as the function to memoize or the import to replace.
6. Do not modify the code unless the user asks for changes.

## 3. Guidelines
The file `references/web-performance-guidelines.md` is a must-have knowledge base for this skill. It ships inside the skill folder so it works offline and always matches the installed version. Use it as the reference for every check. Do not fetch guidelines from the network.

## 4. Output
The output should be a structured report that includes the overall quality of the code ("Good", "Fair", "Poor"), a list of specific issues found in the code with their severity, guideline rule, location, and recommendation, and a list of rules that could not be assessed from the code. The next table shows the criteria for determining the overall quality:

| Overall Quality | Criteria |
|-----------------|----------|
| Good            | No violations found, or only minor ones that have no measurable effect on the user. |
| Fair            | Violations found that may slow the page or waste memory or bandwidth, but none of them blocks the user or grows without limit. |
| Poor            | Violations that leak memory, block the main thread on user interaction, delay the first render, or grow without limit. |

Use the next emojis for the overall quality levels:
- Good: ✅
- Fair: ⚠️
- Poor: ❌

The severity of each issue should be categorized as "High", "Medium", or "Low" based on its likely impact on the user. The criteria are as follows:

| Severity | Criteria |
|----------|----------|
| High     | Causes a memory leak, blocks the main thread during user interaction, delays the first render, or grows without bound. |
| Medium   | Causes unnecessary re-renders, requests, or bytes, but does not block the user or grow without bound. |
| Low      | A minor optimization with little effect on the user. |

Use the next emojis for the severity levels:
- High: 🔴
- Medium: 🟠
- Low: 🟢

The following snippet is an example of the output format to follow when providing feedback; do not skip any of the points.

```md
# Web Performance Review
**Timestamp**: YYYY-MM-DD HH:MM:SS
**Overall Quality**: ✅ Good / ⚠️ Fair / ❌ Poor
**Scope**: Files reviewed, and the source they came from (named by the user, staged changes, or latest commit)

## Issues Found
1. **Issue 1**: Title of the issue found in the code.
    - **Severity**: 🔴 High / 🟠 Medium / 🟢 Low
    - **Guideline**: Rule number in `references/web-performance-guidelines.md`.
    - **Description**: A detailed explanation of the issue, including why it affects the user and how it grows over time.
    - **Location**: Relative file name and line number.
    - **Recommendation**: Specific change to make.
2. **Issue 2**: Title of the issue found in the code.
    - **Severity**: 🔴 High / 🟠 Medium / 🟢 Low
    - **Guideline**: Rule number in `references/web-performance-guidelines.md`.
    - **Description**: A detailed explanation of the issue, including why it affects the user and how it grows over time.
    - **Location**: Relative file name and line number.
    - **Recommendation**: Specific change to make.
3. ...

## Not Assessed
- Rule number and name: why it cannot be judged from the code, and the data that would settle it (for example, a Lighthouse run or a field-data report).
```

Show the complete report in the chat. Do not write a file to the repository unless the user asks for one. If they ask for a file, save it in the project root as `web-performance-review-YYYY-MM-DD_HH-mm-ss.md`, using local time.
