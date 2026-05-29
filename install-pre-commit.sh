#!/usr/bin/env bash
set -euo pipefail

echo "==> Instalare dependente PreCommit-Shield (macOS)"
echo "    Google Style Guides enforcement + PMD bug detection"
echo ""

# 1. Homebrew check
if ! command -v brew &>/dev/null; then
  echo "EROARE: Homebrew nu este instalat. Instaleaza de la https://brew.sh" >&2
  exit 1
fi

# 2. Dependente sistem via Homebrew
echo "--> brew install pre-commit gitleaks trivy scalafmt shellcheck shfmt"
brew install pre-commit gitleaks trivy scalafmt shellcheck shfmt

# 2b. PMD (auto-downloaded by scripts/run-pmd.sh if not installed)
if command -v pmd &>/dev/null; then
  echo "--> PMD already installed: $(pmd --version 2>/dev/null || echo 'unknown version')"
else
  echo "--> PMD will be auto-downloaded on first pre-commit run"
fi

# 3. Hook-uri git pentru repo-ul curent
echo "--> pre-commit install"
pre-commit install

# 4. Node.js check + NPM dependencies
if ! command -v npm &>/dev/null; then
  echo "EROARE: npm nu este instalat. Instaleaza Node.js de la https://nodejs.org" >&2
  exit 1
fi

echo "--> npm install dev dependencies (ESLint Google, Prettier, gts, markdownlint, htmlhint, stylelint)"
npm install --save-dev \
  eslint \
  eslint-config-google \
  prettier \
  gts \
  typescript \
  markdownlint-cli \
  htmlhint \
  stylelint \
  stylelint-config-standard

# 5. Python dependencies
if command -v pip &>/dev/null || command -v pip3 &>/dev/null; then
  PIP_CMD=$(command -v pip3 || command -v pip)
  echo "--> $PIP_CMD install yapf pylint"
  $PIP_CMD install yapf pylint
else
  echo "AVERTISMENT: pip/pip3 nu este instalat. Instaleaza Python pentru Google Python Style hooks." >&2
fi

echo ""
echo "==> Instalare finalizata!"
echo "    Ruleaza 'pre-commit run --all-files' pentru verificare."
echo ""
echo "    Google Style Guides active:"
echo "    - JavaScript  : ESLint + eslint-config-google"
echo "    - Java        : google-java-format + PMD (bug detection)"
echo "    - Python      : yapf (google style) + pylint"
echo "    - TypeScript  : gts (Google TypeScript Style)"
echo "    - Shell       : shellcheck + shfmt"
echo "    - Markdown    : markdownlint"
echo "    - HTML        : htmlhint"
echo "    - CSS         : stylelint"
echo "    - Scala       : scalafmt"
