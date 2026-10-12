#!/usr/bin/env bash

# ./update.sh update every app listed in sources.json
# ./update.sh photocraft update only the named app(s)
# Prints "<app>: <old> -> <new>"
# the hashes come from the SHA256SUMS.txt
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

ORG=storytold
FILE=sources.json
SYSTEMS=("x86_64-linux:x86_64" "aarch64-linux:aarch64")

# sha256 hex -> SRI ("sha256-<base64>")
sri() {
  local hex=$1 esc="" i
  for ((i = 0; i < ${#hex}; i += 2)); do esc+="\\x${hex:i:2}"; done
  printf 'sha256-%s' "$(printf '%b' "$esc" | base64 | tr -d '\n')"
}

update_app() {
  local app=$1 url tag ver old sums hashes='{}' pair sys arch hex

  url=$(curl -fsSIL -o /dev/null -w '%{url_effective}' "https://github.com/$ORG/$app/releases/latest") || return 1
  [[ $url == */releases/tag/* ]] || { echo "$app: no release found" >&2; return 1; }
  tag=${url##*/}
  ver=${tag#v}

  old=$(jq -r --arg a "$app" '.[$a].version // ""' "$FILE") || return 1
  [[ $ver != "$old" ]] || return 0

  sums=$(curl -fsSL "https://github.com/$ORG/$app/releases/download/$tag/SHA256SUMS.txt") || return 1
  for pair in "${SYSTEMS[@]}"; do
    sys=${pair%%:*}
    arch=${pair##*:}
    hex=$(awk -v f="$app-$ver-linux-$arch.AppImage" '{ sub(/^\*/, "", $2) } $2 == f { print $1 }' <<<"$sums") || return 1
    [[ $hex =~ ^[0-9a-f]{64}$ ]] || { echo "$app $ver: no checksum for $arch" >&2; return 1; }
    hashes=$(jq -c --arg s "$sys" --arg h "$(sri "$hex")" '. + {($s): $h}' <<<"$hashes") || return 1
  done

  jq --arg a "$app" --arg v "$ver" --argjson h "$hashes" '.[$a] = {version: $v, hashes: $h}' "$FILE" >"$FILE.tmp" &&
    mv "$FILE.tmp" "$FILE" || return 1
  echo "$app: ${old:-new} -> $ver"
}

apps=("$@")
((${#apps[@]})) || mapfile -t apps < <(jq -r 'keys[]' "$FILE")

failed=0
for app in "${apps[@]}"; do
  update_app "$app" || { echo "warning: could not update $app" >&2; failed=1; }
done
exit "$failed"
