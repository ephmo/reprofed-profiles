#!/usr/bin/env bash
set -euo pipefail
shopt -s globstar nullglob

PROFILES_DIR="profiles"
EXIT_CODE=0

if ! command -v yq > /dev/null 2>&1; then
  echo "❌ yq is required but not installed"
  exit 1
fi

if [[ ! -d "$PROFILES_DIR" ]]; then
  echo "❌ Profiles directory not found: $PROFILES_DIR"
  exit 1
fi

PROFILE_FILES=(
  "$PROFILES_DIR"/**/*.yaml
)

if [[ ${#PROFILE_FILES[@]} -eq 0 ]]; then
  echo "❌ No YAML profile files found in $PROFILES_DIR/"
  exit 1
fi

fail() {
  echo "  ❌ $1"
  FILE_OK=false
}

yaml() {
  yq eval "$1" "$file"
}

require_key() {
  local path="$1"
  local value
  value=$(yaml ".${path}")

  if [[ "$value" == "null" || -z "$value" ]]; then
    fail "Missing or null required key: ${path}"
  fi
}

require_equals() {
  local path="$1"
  local expected="$2"
  local value
  value=$(yaml ".${path}")

  if [[ "$value" != "$expected" ]]; then
    fail "${path} must be '${expected}' (found: ${value})"
  fi
}

require_boolean() {
  local path="$1"
  local value
  value=$(yaml ".${path}")

  if [[ "$value" != "true" && "$value" != "false" ]]; then
    fail "${path} must be a boolean (true or false)"
  fi
}

require_array_contains() {
  local path="$1"
  local expected="$2"

  if ! yq eval ".${path}[]" "$file" | grep -qx "$expected"; then
    fail "${path} must contain ${expected}"
  fi
}

echo "🔍 Validating profile files"
echo

for file in "${PROFILE_FILES[@]}"; do
  echo "▶ Checking ${file}"
  FILE_OK=true

  require_key "metadata.name"
  require_key "metadata.description"
  require_equals "metadata.version" "1.0.0"
  require_key "metadata.maintainer"
  require_key "metadata.release_date"
  require_key "metadata.last_modified"
  require_equals "requires.distro" "fedora"
  require_array_contains "requires.distro_versions" "42"
  require_array_contains "requires.distro_versions" "43"
  require_equals "requires.arch" "x86_64"
  require_boolean "repos.rpmfusion-free"
  require_boolean "repos.rpmfusion-nonfree"
  require_boolean "repos.flathub"
  require_boolean "repos.vscode"
  require_key "packages.install.all_versions"
  require_key "services.set-default"

  if [[ "$FILE_OK" == true ]]; then
    echo "  ✅ OK"
  else
    EXIT_CODE=1
  fi

  echo
done

if [[ $EXIT_CODE -ne 0 ]]; then
  echo "❌ Profile validation failed"
else
  echo "🎉 All profiles are valid"
fi

exit $EXIT_CODE
