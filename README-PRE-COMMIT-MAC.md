# Configurare Pre-Commit pe macOS

## 1. Instalare Dependențe

```bash
# Core tools
brew install pre-commit gitleaks trivy scalafmt shellcheck shfmt

# Node.js dependencies (ESLint, Prettier, gts, markdownlint, htmlhint, stylelint)
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

# Python dependencies (yapf, pylint)
pip install yapf pylint
```

## 2. Configurare Proiect

```bash
# Activează hook-urile pre-commit în repo
pre-commit install
```

## 3. Verificare

```bash
# Rulează toate hook-urile pe toate fișierele
pre-commit run --all-files
```

## 4. Rulare individuală (opțional)

```bash
# Doar un hook specific:
pre-commit run eslint --all-files
pre-commit run pretty-format-java --all-files
pre-commit run pmd-java --all-files
pre-commit run yapf --all-files
pre-commit run shellcheck --all-files
pre-commit run shfmt --all-files
pre-commit run markdownlint --all-files
pre-commit run gitleaks --all-files
```

## 5. Actualizare hook-uri

```bash
pre-commit autoupdate
```
