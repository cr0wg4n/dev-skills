---
name: vue-code-review
description: A skill designed to review Vue.js code for quality, maintainability, and adherence to best practices, providing feedback and recommendations for improvement.
---

# vue-code-review

This is a skill designed to review Vue.js code for quality, maintainability, and adherence to best practices. It provides feedback on the code based on a set of guidelines (section 3) and generates a structured report highlighting any issues found (section 4), along with recommendations for improvement.

## 1. When to use
This skill is used as a quality check for Vue.js code, ideally before a code review or during a code review. 

## 2. Instructions
1. Before anything fetch the latest guidelines (`vue-code-guidelines.md` file) from the URL provided in section 3, Guidelines, use it later as context for providing recommendations and best practices.
2. Check the latest commit or the current staged changes for Vue.js files; the user should provide the scope, or if not available or ambiguous, you can ask for the relevant code and scope to analyze. 
3. Check the code against the guidelines (`vue-code-guidelines.md`) provided below in section 3, Guidelines.
4. Provide feedback and suggestions based on the guidelines, highlighting the areas that do not follow the guidelines and offer specific recommendations for improvement based on the knowledge base; the output you provide should follow the syntax mentioned in the section 4, Output.

## 3. Guidelines
Fetch the `vue-code-guidelines.md` file for a comprehensive list of Vue.js best practices and guidelines. Use web fetch to retrieve the latest rules from this URL:

```
https://raw.githubusercontent.com/cr0wg4n/dev-skills/main/docs/guidelines/vue-code-guidelines.md
```

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
# Vue.js Code Review Feedback
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

Finally, create a file called `vue-code-review-${timestamp}.md` in the root project folder with the complete output.