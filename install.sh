#!/usr/bin/env bash
# Install a Copilot skill (and its prompts) to user-global locations on macOS/Linux.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/skylercong-cloud/copilot-skills/main/install.sh | bash -s -- --skill shopify-page-dev --force
#
set -euo pipefail

SKILL="shopify-page-dev"
REPO="https://github.com/skylercong-cloud/copilot-skills.git"
REF="main"
FORCE=0
NO_PROMPTS=0
LIST=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --skill)        SKILL="$2"; shift 2 ;;
    --repo)         REPO="$2"; shift 2 ;;
    --ref)          REF="$2"; shift 2 ;;
    --force)        FORCE=1; shift ;;
    --no-prompts)   NO_PROMPTS=1; shift ;;
    --list)         LIST=1; shift ;;
    -h|--help)
      sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

bold() { printf "\033[1;36m==> %s\033[0m\n" "$*"; }
ok()   { printf "  \033[1;32m[OK]\033[0m %s\n" "$*"; }
skip() { printf "  \033[1;33m[SKIP]\033[0m %s\n" "$*"; }
warn() { printf "  \033[1;33m[!]\033[0m %s\n" "$*"; }

SKILLS_DIR="$HOME/.copilot/skills"

case "$(uname -s)" in
  Darwin) PROMPTS_DIR="$HOME/Library/Application Support/Code/User/prompts" ;;
  Linux)  PROMPTS_DIR="$HOME/.config/Code/User/prompts" ;;
  *)      PROMPTS_DIR="$HOME/.config/Code/User/prompts" ;;
esac

TMP="$(mktemp -d -t copilot-skills.XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

bold "Fetching repo $REPO ($REF)"
if command -v git >/dev/null 2>&1; then
  git clone --depth 1 --branch "$REF" "$REPO" "$TMP" >/dev/null 2>&1
  ok "cloned via git"
else
  ZIP_BASE="${REPO%.git}"
  ZIP_URL="$ZIP_BASE/archive/refs/heads/$REF.tar.gz"
  curl -fsSL "$ZIP_URL" | tar -xz -C "$TMP" --strip-components=1
  ok "downloaded via tarball"
fi

if [[ "$LIST" -eq 1 ]]; then
  bold "Available skills"
  if [[ -f "$TMP/manifest.json" ]]; then
    if command -v jq >/dev/null 2>&1; then
      jq -r '.skills[] | "  - \(.name)  (v\(.version))  \(.description)"' "$TMP/manifest.json"
    else
      cat "$TMP/manifest.json"
    fi
  else
    warn "manifest.json not found"
  fi
  exit 0
fi

SKILL_SRC="$TMP/skills/$SKILL"
[[ -d "$SKILL_SRC" ]] || { echo "Skill '$SKILL' not found in repo. Use --list to see available skills." >&2; exit 1; }

bold "Installing skill: $SKILL"
mkdir -p "$SKILLS_DIR"
SKILL_DST="$SKILLS_DIR/$SKILL"
if [[ -d "$SKILL_DST" && "$FORCE" -ne 1 ]]; then
  warn "skill already installed at $SKILL_DST"
  warn "rerun with --force to overwrite"
else
  rm -rf "$SKILL_DST"
  mkdir -p "$SKILL_DST"
  # copy everything except prompts/
  (cd "$SKILL_SRC" && find . -mindepth 1 -maxdepth 1 ! -name prompts -exec cp -R {} "$SKILL_DST"/ \;)
  ok "installed -> $SKILL_DST"
fi

if [[ "$NO_PROMPTS" -ne 1 && -d "$SKILL_SRC/prompts" ]]; then
  bold "Installing prompts -> $PROMPTS_DIR"
  mkdir -p "$PROMPTS_DIR"
  shopt -s nullglob
  for p in "$SKILL_SRC"/prompts/*.prompt.md; do
    name="$(basename "$p")"
    target="$PROMPTS_DIR/$name"
    if [[ -f "$target" && "$FORCE" -ne 1 ]]; then
      skip "$name (exists, use --force)"
    else
      cp "$p" "$target"
      ok "$name"
    fi
  done
fi

# .installed.json
META="$SKILL_DST/.installed.json"
if [[ -d "$SKILL_DST" ]]; then
  COMMIT=""
  if command -v git >/dev/null 2>&1; then
    COMMIT="$(git -C "$TMP" rev-parse HEAD 2>/dev/null || true)"
  fi
  cat > "$META" <<EOF
{
  "skill": "$SKILL",
  "repo": "$REPO",
  "ref": "$REF",
  "commit": "$COMMIT",
  "installedAt": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
fi

bold "Post-install checks"
if [[ -z "${FIGMA_API_KEY:-}" ]]; then
  warn "FIGMA_API_KEY is not set."
  echo  "         Add to your shell rc:  export FIGMA_API_KEY=\"figd_xxxx\""
else
  ok "FIGMA_API_KEY is set"
fi

if [[ -f "$TMP/shared/mcp-figma.snippet.json" ]]; then
  warn "Make sure your VS Code MCP config includes the Figma server."
  echo "         Snippet to merge:"
  echo
  sed 's/^/    /' "$TMP/shared/mcp-figma.snippet.json"
  echo
  echo "         Add it to your project's .vscode/mcp.json or VS Code user settings.json (chat.mcp.servers)."
fi

bold "Done"
echo "Skill:   $SKILL_DST"
[[ "$NO_PROMPTS" -ne 1 ]] && echo "Prompts: $PROMPTS_DIR"
