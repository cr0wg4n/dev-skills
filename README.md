<img src="https://raw.githubusercontent.com/cr0wg4n/dev-skills/refs/heads/main/docs/assets/dev-skills.png" alt="Dev Skills Logo" width="100%" />

# Dev Skills

[![skills.sh](https://skills.sh/b/cr0wg4n/dev-skills)](https://skills.sh/cr0wg4n/dev-skills)

> Stop rewriting the same code review comments. Let your AI agent enforce your team's standards automatically.

**Dev Skills** is a well selected collection of real software engineering best practices, experiences and guidelines — so your AI assistant gives consistent, opinionated feedback across your entire team, not generic advice.

---

## 📦 What's inside

| Skill | What it does |
|-------|--------------|
| `vue-code-review` | Reviews Vue 3 code against battle-tested guidelines: component structure, Composition API patterns, reactivity pitfalls, and more. |
| `vue-builder` | Guides you through building Vue apps the right way — folder structure, state management, component design, naming conventions. |
| `ts-code-review` | Reviews TypeScript code for best practices, type safety, and common pitfalls. |
| `ts-builder` | Helps you build TypeScript projects with proper guidelines, and best practices. |
| `poor-web-performance` | Introduces bad performance practices into web applications, including memory leaks, UI blocking, and inefficient algorithms, to intentionally degrade performance and create a poor user experience. **An experimental skill for testing, learning, or simply self-sabotage** 😝. Forced to put this skill on paper by [ProfessorByte](https://github.com/ProfessorByte) |
---

## ⚡ Install in 20 seconds

```bash
npx skills add cr0wg4n/dev-skills
```

**Supported AI tools:** Claude Code, Cursor, and anything compatible with [skills.sh](https://skills.sh).

---

## 🤖 How it works

Once installed, your AI assistant gains context about these opinionated guideline standards.

For example, when you develop a Vue 3 + TypeScript application, your AI assistant will automatically review it against the `/vue-code-review` and `/ts-code-review` skills, giving you consistent feedback based on the skills before creating a Pull Request, so you can improve your code even before submitting it.

Prompt when need review:
```
Check the latest commit in this branch against the /vue-code-review and /ts-code-review skills, and give me feedback on how to improve my code.
```

When you are actively developing a project, your AI assistant can guide you through setting up the project structure, configuration, and ensuring long-term application resilience using the `/vue-builder` and `/ts-builder` skills.

Prompt when you want to integrate the knowledge into the development process:

```
I want ..., use the /vue-builder and /ts-builder skills throughout the complete process and introduce the changes accordingly.
```

---

## 🤝 Contribute

Want to add a skill for your stack? Read [CONTRIBUTING.md](CONTRIBUTING.md) to get started.

---

> Found this useful? Share it with your team. One install saves hours of repeated feedback.

Made with ❤️ by [cr0wg4n](https://github.com/cr0wg4n)
