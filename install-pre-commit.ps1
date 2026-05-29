# PreCommit-Shield - Windows Installer (PowerShell)
# Google Style Guides enforcement

Write-Host "==> Instalare dependente PreCommit-Shield (Windows)" -ForegroundColor Cyan
Write-Host "    Google Style Guides enforcement + PMD bug detection" -ForegroundColor Cyan
Write-Host ""

# 1. Core tools
Write-Host "--> Instalare pre-commit, gitleaks, trivy, scalafmt" -ForegroundColor Yellow
pip install pre-commit
winget install gitleaks --accept-package-agreements --accept-source-agreements
winget install aquasecurity.trivy --accept-package-agreements --accept-source-agreements
winget install scalameta.scalafmt --accept-package-agreements --accept-source-agreements

# 2. shellcheck & shfmt via scoop (if available)
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "--> scoop install shellcheck shfmt" -ForegroundColor Yellow
    scoop install shellcheck shfmt
} else {
    Write-Host "AVERTISMENT: scoop nu este instalat. Instaleaza scoop (https://scoop.sh) pentru shellcheck si shfmt." -ForegroundColor Red
}

# 3. Hook-uri git
Write-Host "--> pre-commit install" -ForegroundColor Yellow
pre-commit install

# 4. NPM dependencies
if (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host "--> npm install dev dependencies (Google Style tools)" -ForegroundColor Yellow
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
} else {
    Write-Host "EROARE: npm nu este instalat. Instaleaza Node.js de la https://nodejs.org" -ForegroundColor Red
    exit 1
}

# 5. Python dependencies
Write-Host "--> pip install yapf pylint" -ForegroundColor Yellow
pip install yapf pylint

Write-Host ""
Write-Host "==> Instalare finalizata!" -ForegroundColor Green
Write-Host "    Ruleaza 'pre-commit run --all-files' pentru verificare." -ForegroundColor Green
Write-Host ""
Write-Host "    Google Style Guides active:" -ForegroundColor Cyan
Write-Host "    - JavaScript  : ESLint + eslint-config-google"
Write-Host "    - Java        : google-java-format + PMD (bug detection)"
Write-Host "    - Python      : yapf (google style) + pylint"
Write-Host "    - TypeScript  : gts (Google TypeScript Style)"
Write-Host "    - Shell       : shellcheck + shfmt"
Write-Host "    - Markdown    : markdownlint"
Write-Host "    - HTML        : htmlhint"
Write-Host "    - CSS         : stylelint"
Write-Host "    - Scala       : scalafmt"
