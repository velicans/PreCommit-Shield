# 🛡️ PreCommit-Shield

**Automated pre-commit hooks enforcing [Google Style Guides](https://google.github.io/styleguide/) across 10 languages.**

One config to rule them all — secrets scanning, vulnerability checks, and code formatting that runs automatically before every commit.

---

## 🎯 Supported Languages & Google Standards

| # | Language | Formatter / Linter | Google Style Guide | Auto-fix |
|---|----------|--------------------|--------------------|----------|
| 1 | **JavaScript** | ESLint + `eslint-config-google` | [JS Style Guide](https://google.github.io/styleguide/jsguide.html) | ✅ |
| 2 | **JSON** | Prettier | [JSON Style Guide](https://google.github.io/styleguide/jsoncstyleguide.xml) | ✅ |
| 3 | **Java** | `google-java-format` | [Java Style Guide](https://google.github.io/styleguide/javaguide.html) | ✅ |
| 4 | **Python** | `yapf` + `pylint` | [Python Style Guide](https://google.github.io/styleguide/pyguide.html) | ✅ |
| 5 | **TypeScript** | `gts` (Google TypeScript Style) | [TS Style Guide](https://google.github.io/styleguide/tsguide.html) | ✅ |
| 6 | **Shell / Bash** | `shellcheck` + `shfmt` | [Shell Style Guide](https://google.github.io/styleguide/shellguide.html) | ✅ |
| 7 | **Markdown** | `markdownlint` | [Markdown Style Guide](https://google.github.io/styleguide/docguide/style.html) | ✅ |
| 8 | **HTML** | `htmlhint` | [HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.html) | — |
| 9 | **CSS / SCSS** | `stylelint` | [HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.html) | ✅ |
| 10 | **Scala** | `scalafmt` | Custom config | ✅ |

## 🔒 Security Hooks

| Tool | What it catches |
|------|-----------------|
| **[Gitleaks](https://github.com/gitleaks/gitleaks)** | API keys, passwords, tokens, private keys committed by mistake |
| **[Trivy](https://github.com/aquasecurity/trivy)** | Known CVEs in dependencies (`CRITICAL` / `HIGH`) and Dockerfile misconfigurations |

---

## 🚀 Quick Start

### macOS

```bash
./install-pre-commit.sh
```

> Detailed steps → [README-PRE-COMMIT-MAC.md](README-PRE-COMMIT-MAC.md)

### Windows

```powershell
.\install-pre-commit.ps1
```

> Detailed steps → [README-PRE-COMMIT-WINDOWS.md](README-PRE-COMMIT-WINDOWS.md)

### Verify

```bash
pre-commit run --all-files
```

---

## 🏗️ Architecture

```text
PreCommit-Shield/
├── .pre-commit-config.yaml    # 15 hooks — the main config
│
├── eslint.config.mjs          # JS  → Google JavaScript Style
├── .prettierrc.json           # JS/JSON → Google-compatible formatting
├── .markdownlint.json         # MD  → Google Markdown Style
├── .htmlhintrc                # HTML → Google HTML Style
├── .stylelintrc.json          # CSS → Google CSS Style
├── .pylintrc                  # PY  → Google Python linting
├── setup.cfg                  # PY  → yapf Google formatting
│
├── install-pre-commit.sh      # macOS installer
├── install-pre-commit.ps1     # Windows installer
├── README-PRE-COMMIT-MAC.md   # macOS setup guide
└── README-PRE-COMMIT-WINDOWS.md  # Windows setup guide
```

---

## 📐 Key Google Style Rules Enforced

### JavaScript / TypeScript

- **2-space** indentation
- **80-character** line limit
- Single quotes (`'`)
- Semicolons always
- Trailing commas in multiline constructs
- `const` / `let` — no `var`
- `camelCase` naming

### Java

- **Google Java Format** — canonical, non-configurable
- **2-space** indentation
- **100-character** line limit
- Google import ordering

### Python

- **4-space** indentation
- **80-character** line limit
- Google-style docstrings
- `snake_case` naming
- No wildcard imports

### Shell / Bash

- **2-space** indentation
- `shellcheck` severity ≥ warning
- Binary operators at start of next line (`-bn`)
- Case statement indent (`-ci`)

### Markdown

- ATX-style headings (`#`, not underlines)
- Fenced code blocks with language specifier
- **80-character** line limit (code blocks excluded)
- Newline at end of file

### HTML / CSS

- Lowercase tag and attribute names
- Double quotes for attribute values
- **2-space** indentation
- Short hex colors (`#fff` not `#ffffff`)
- No vendor prefixes / no `!important`

---

## 🔧 Hook-by-Hook Reference

| # | Hook ID | Tool | Runs on | Mode |
|---|---------|------|---------|------|
| 1 | `gitleaks` | Gitleaks | all files | check |
| 2 | `eslint` | ESLint | `.js` `.mjs` `.cjs` | fix |
| 3 | `prettier` | Prettier | `.js` `.json` | fix |
| 4 | `pretty-format-java` | google-java-format | `.java` | fix |
| 5 | `yapf` | yapf | `.py` | fix |
| 6 | `pylint-google` | Pylint | `.py` | check |
| 7 | `gts-lint` | gts | `.ts` | check |
| 8 | `shellcheck` | ShellCheck | `.sh` `.bash` | check |
| 9 | `shfmt` | shfmt | `.sh` `.bash` | fix |
| 10 | `markdownlint` | markdownlint-cli | `.md` | fix |
| 11 | `htmlhint` | HTMLHint | `.html` | check |
| 12 | `stylelint` | Stylelint | `.css` `.scss` | fix |
| 13 | `trivy-dependency-scan` | Trivy | all | check |
| 14 | `trivy-docker-scan` | Trivy | `Dockerfile` | check |
| 15 | `scalafmt` | Scalafmt | `.scala` | fix |

---

## 🔄 Updating Hooks

```bash
# Update all hooks to latest versions
pre-commit autoupdate

# Run a single hook manually
pre-commit run eslint --all-files
pre-commit run pretty-format-java --all-files
pre-commit run markdownlint --all-files
```

---

## 📚 References

- [Google Style Guides (all languages)](https://google.github.io/styleguide/)
- [pre-commit framework](https://pre-commit.com/)
- [Gitleaks](https://github.com/gitleaks/gitleaks)
- [Trivy](https://github.com/aquasecurity/trivy)
- [google-java-format](https://github.com/google/google-java-format)
- [eslint-config-google](https://github.com/google/eslint-config-google)
- [gts — Google TypeScript Style](https://github.com/google/gts)
- [yapf — Google Python formatter](https://github.com/google/yapf)
