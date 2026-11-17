---
name: ts-code-review
description: Reviews TypeScript code against team guidelines covering naming, typing, functions, interfaces, classes, modules, async code, and error handling, and returns a graded report of severity-ranked issues. Use when the user asks to review, audit, critique, or give feedback on .ts or .tsx files, a TypeScript pull request, or the latest commit or staged changes in a TypeScript project, before opening a PR or during code review. Also use it for indirect requests like "is this typed correctly?", "check my TS changes", or "anything wrong with this module?", even when the word "review" never appears. Not for Vue single-file components; use vue-code-review for those. Not for building new code; use ts-builder for that.
---

# ts-code-review

This is a skill designed to review TypeScript code for quality, maintainability, and adherence to best practices. It provides feedback on the code based on a set of guidelines (section 3) and generates a structured report highlighting any issues found (section 4), along with recommendations for improvement.

## 1. When to use
This skill is used as a quality check for TypeScript code, ideally before a code review or during a code review. 

## 2. Instructions
1. Before anything, read the guidelines file `references/typescript-code-guidelines.md` bundled with this skill, and use it as context for providing recommendations and best practices.
2. Determine the scope, using the first source that yields `.ts` or `.tsx` files:
   - (a) the files or diff the user named in the request;
   - (b) staged changes, listed with `git diff --cached --name-only`;
   - (c) the latest commit, listed with `git show --name-only --format= HEAD`.
   If none of these yields TypeScript files, or the scope is still unclear, ask the user what to review before continuing. Do not guess a scope and do not review files outside it. 
3. Check the code against the guidelines in `references/typescript-code-guidelines.md`, described in section 3, Guidelines.
4. Provide feedback and suggestions based on the guidelines, highlighting the areas that do not follow the guidelines and offer specific recommendations for improvement based on the knowledge base; the output you provide should follow the syntax mentioned in the section 4, Output.

## 3. Guidelines
The file `references/typescript-code-guidelines.md` is a must-have knowledge base for this skill. It ships inside the skill folder so it works offline and always matches the installed version. Use it as the reference for providing recommendations and best practices when reviewing TypeScript code. Do not fetch guidelines from the network.

## 4. Output
The output should be a structured report that includes the overall quality of the code ("Good", "Fair", "Poor") and a list of specific issues found in the code, along with their severity, location, and recommendations for improvement. The next table shows the criteria for determining the overall quality of the code:

| Overall Quality | Criteria |
|-----------------|----------|
| Good            | No issues found or only minor issues that do not affect the functionality or maintainability of the code. |
| Fair            | Some issues found that may affect the functionality or maintainability of the code, but they are not critical. |
| Poor            | Multiple issues found that significantly affect the functionality or maintainability of the code, or there are critical issues that need immediate attention. |

Use the next emojis for the overall quality levels:
- Good: ✅
- Fair: ⚠️
- Poor: ❌

The severity of each issue should be categorized as "High", "Medium", or "Low" based on the potential impact on the functionality, maintainability, or readability of the code. The criteria for determining the severity of issues are as follows:

| Severity | Criteria |
|----------|----------|
| High     | Issues that can cause bugs, security vulnerabilities, or significantly degrade the performance of the application. |
| Medium   | Issues that may lead to confusion, reduce readability, or make the code harder to maintain, but do not directly cause bugs or security vulnerabilities. |
| Low      | Issues that are mostly related to code style, formatting, or minor best practices that do not affect the functionality or maintainability of the code. |

Use the next emojis for the severity levels:
- High: 🔴
- Medium: 🟠
- Low: 🟢

The following snippet is an example of the output format to follow when providing feedback; do not skip any of the points.

```md
# TypeScript Code Review Feedback
**Timestamp**: YYYY-MM-DD HH:MM:SS
**Overall Quality**: ✅ Good / ⚠️ Fair / ❌ Poor

## Issues Found
1. **Issue 1**: Title of the issue found in the code.
    - **Severity**: 🔴 High / 🟠 Medium / 🟢 Low
    - **Description**: A detailed explanation of the issue, including why it is a problem and how it affects the code in the long run.
    - **Location**: Relative file name and line number.
    - **Recommendation**: Specific recommendation for improvement.  
2. **Issue 2**: Title of the issue found in the code.
    - **Severity**: 🔴 High / 🟠 Medium / 🟢 Low
    - **Description**: A detailed explanation of the issue, including why it is a problem and how it affects the code in the long run.
    - **Location**: Relative file name and line number.
    - **Recommendation**: Specific recommendation for improvement.  
3. ...
```

Show the complete report in the chat. Do not write a file to the repository unless the user asks for one. If they ask for a file, save it in the project root as `ts-code-review-YYYY-MM-DD_HH-mm-ss.md`, using local time, to match the naming used by `vue-code-review` examples.
