# Contributing to Dev Skills

Dev Skills encodes real engineering guidelines into agentic skills — so AI assistants give consistent, opinionated feedback instead of generic advice. Every contribution should make that promise stronger.

---

## What is a skill?

A skill is a `SKILL.md` file that tells an AI agent **what to do**, **when to do it**, and **how to output results**. It lives at:

```
skills/<skill-name>/SKILL.md
```

The agent reads this file at runtime and follows its instructions. Think of it as a playbook, not a library.

---

## Skill anatomy

Every `SKILL.md` must follow this structure:

```markdown
---
name: my-skill
description: One sentence. What the skill does and for whom.
---

# my-skill

Brief intro paragraph.

## 1. When to use
Describe the exact scenarios that trigger this skill.

## 2. Instructions
Step-by-step instructions the agent will follow. Be specific and imperative.

## 3. Guidelines
Point to the authoritative guidelines file the agent should fetch.
Use a raw GitHub URL so it always pulls the latest version.

## 4. Output
Define the exact output format: structure, fields, file name, emojis, severity levels, etc.
```

All four sections are **required**. The agent reads them literally — vague instructions produce vague results.

---

## Adding a new skill

### 1. Create the skill folder and file

```bash
mkdir skills/my-skill
touch skills/my-skill/SKILL.md
```

### 2. Write the guidelines (if needed)

If your skill references guidelines, host them in `docs/guidelines/`:

```
docs/guidelines/my-stack-guidelines.md
```

Commit guidelines to `main` before referencing them via raw GitHub URL. The URL pattern is:

```
https://raw.githubusercontent.com/cr0wg4n/dev-skills/main/docs/guidelines/<file>.md
```

### 3. Register in `skills.sh.json`

Add your skill to an existing group or create a new one:

```json
{
  "$schema": "https://skills.sh/schemas/skills.sh.schema.json",
  "notGrouped": "bottom",
  "groupings": [
    {
      "title": "Vue",
      "description": "A skill designed to review Vue.js code for quality, maintainability, and adherence to best practices, providing feedback and recommendations for improvement.",
      "skills": [
        "vue-code-review",
        "vue-builder"
        // ... if its vue specific
      ]
    },
    {
      // ... or create a new group if it doesn't fit existing ones
    }
  ]
}

```

### 4. Add an example (recommended)

Place a small, self-contained example app or code snippet in `example/`. It helps reviewers verify the skill works correctly and serves as a test bed.

```
example/my-skill-example/
```

### 5. Open a pull request

Include in the PR description:
- What problem this skill solves
- A sample invocation and its output
- Link to any guidelines file added

---

## Updating an existing skill

- **Guidelines changes** go in `docs/guidelines/`. Skills fetch them dynamically via URL — no changes to `SKILL.md` needed unless the URL or structure changes.
- **Instruction changes** in `SKILL.md` must be intentional. Test the updated skill against the example app before submitting.
- **Output format changes** require updating all examples that depend on that format.

---

## Quality bar for skills

A skill is ready when it meets all of these:

| Check | Requirement |
|-------|-------------|
| Focused | Does one thing well. Not a catch-all. |
| Deterministic | Same input → same output format every time. |
| Grounded | Output tied to fetched guidelines, not the model's memory. |
| Tested | Run it against the example app. Attach output to the PR. |
| Documented | `description` in frontmatter is a complete, standalone sentence. |

---

## Coding conventions

This repository uses `EditorConfig`, so install the extension for your editor. It keeps the code style consistent. Markdown files are the primary artifact — write clearly and keep lines readable.

It is not enforced automatically, but commit messages should follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add react-code-review skill
fix: correct severity criteria in vue-code-review output
docs: update contributing guide with example section
```

---

## Not sure where to start?

- Look at `skills/vue-code-review/SKILL.md` — it's the reference implementation.
- Check open issues for skills requested by the community.
- A good first contribution: improve an existing guideline file with a real-world rule you've enforced on your team.
