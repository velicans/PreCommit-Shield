#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# PMD wrapper for pre-commit hook
# Downloads PMD automatically if not installed.
# Usage: ./scripts/run-pmd.sh [file1.java file2.java ...]
# ============================================================

PMD_VERSION="7.25.0"
PMD_DIR="${HOME}/.pmd/pmd-bin-${PMD_VERSION}"
PMD_ZIP="pmd-dist-${PMD_VERSION}-bin.zip"
PMD_URL="https://github.com/pmd/pmd/releases/download/pmd_releases%2F${PMD_VERSION}/${PMD_ZIP}"
RULESET="$(cd "$(dirname "$0")/.." && pwd)/pmd-ruleset.xml"

# --- Locate PMD binary ---
if command -v pmd &>/dev/null; then
  PMD_CMD="pmd"
elif [[ -x "${PMD_DIR}/bin/pmd" ]]; then
  PMD_CMD="${PMD_DIR}/bin/pmd"
else
  echo "[PMD] Not found. Downloading PMD ${PMD_VERSION}..."
  mkdir -p "${HOME}/.pmd"
  TMP_DIR=$(mktemp -d)
  curl -sL "${PMD_URL}" -o "${TMP_DIR}/${PMD_ZIP}"
  unzip -qo "${TMP_DIR}/${PMD_ZIP}" -d "${HOME}/.pmd"
  rm -rf "${TMP_DIR}"
  PMD_CMD="${PMD_DIR}/bin/pmd"
  chmod +x "${PMD_CMD}"
  echo "[PMD] Installed to ${PMD_DIR}"
fi

# --- Filter only .java files from arguments ---
JAVA_FILES=()
for f in "$@"; do
  if [[ "${f}" == *.java ]]; then
    JAVA_FILES+=("${f}")
  fi
done

if [[ ${#JAVA_FILES[@]} -eq 0 ]]; then
  echo "[PMD] No Java files to check."
  exit 0
fi

# --- Create a temporary file list (PMD --file-list) ---
FILE_LIST=$(mktemp)
printf '%s\n' "${JAVA_FILES[@]}" > "${FILE_LIST}"

# --- Run PMD ---
echo "[PMD] Checking ${#JAVA_FILES[@]} Java file(s)..."
"${PMD_CMD}" check \
  --file-list "${FILE_LIST}" \
  --rulesets "${RULESET}" \
  --format text \
  --no-progress \
  --no-cache \
  --fail-on-error \
  --fail-on-violation \
  --minimum-priority 3

EXIT_CODE=$?
rm -f "${FILE_LIST}"

if [[ ${EXIT_CODE} -eq 0 ]]; then
  echo "[PMD] All checks passed."
fi

exit ${EXIT_CODE}
