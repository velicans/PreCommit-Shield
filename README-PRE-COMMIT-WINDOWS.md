# Configurare Pre-Commit pe Windows

## 1. Instalare Dependențe (PowerShell Admin)

```powershell
# Core tools
pip install pre-commit
winget install gitleaks
winget install aquasecurity.trivy
winget install scalameta.scalafmt

# shellcheck & shfmt (via scoop - recomandat)
scoop install shellcheck shfmt

# Node.js dependencies
npm install --save-dev `
  eslint `
  eslint-config-google `
  prettier `
  gts `
  typescript `
  markdownlint-cli `
  htmlhint `
  stylelint `
  stylelint-config-standard

# Python dependencies
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
