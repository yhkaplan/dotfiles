#!/usr/bin/env bash
# Idempotent symlink installer driven by symlinks.txt.
#
# Each line of symlinks.txt is:   <source> <destination>
#   - ~ is expanded to $HOME in both fields.
#   - If <destination> ends with "/", the link is created inside that directory
#     using the source's basename. Otherwise <destination> is the full link path.
#
# Behavior:
#   - Skips entries whose symlink is already correct.
#   - On a real conflict, moves the existing file to a timestamped backup dir.
#   - Fails fast if a source file does not exist.

set -Eeuo pipefail

SYMLINKS_FILE="${SYMLINKS_FILE:-$HOME/.dotfiles/symlinks.txt}"
BACKUP_ROOT="${BACKUP_ROOT:-$HOME/.old_dotfiles}"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S)"

if [[ ! -f "$SYMLINKS_FILE" ]]; then
    echo "symlinks file not found: $SYMLINKS_FILE" >&2
    exit 1
fi

expand_tilde() {
    local path="$1"
    printf '%s' "${path/#\~/$HOME}"
}

backed_up=0
ensure_backup_dir() {
    if (( backed_up == 0 )); then
        mkdir -p "$BACKUP_DIR"
        backed_up=1
    fi
}

while IFS= read -r line || [[ -n "$line" ]]; do
    # Skip blank lines and comments.
    [[ -z "${line// /}" || "$line" =~ ^[[:space:]]*# ]] && continue

    # Split on the first whitespace run.
    read -r raw_src raw_dst <<<"$line"
    if [[ -z "${raw_src:-}" || -z "${raw_dst:-}" ]]; then
        echo "malformed entry: $line" >&2
        exit 1
    fi

    src="$(expand_tilde "$raw_src")"
    dst="$(expand_tilde "$raw_dst")"

    # Resolve final link path: trailing slash => directory, use basename.
    if [[ "$dst" == */ ]]; then
        target="${dst%/}/$(basename "$src")"
    else
        target="$dst"
    fi

    if [[ ! -e "$src" ]]; then
        echo "missing source: $src" >&2
        exit 1
    fi

    if [[ -L "$target" && "$(readlink "$target")" == "$src" ]]; then
        echo "✓ $target"
        continue
    fi

    mkdir -p "$(dirname "$target")"

    if [[ -e "$target" || -L "$target" ]]; then
        ensure_backup_dir
        echo "→ backing up $target → $BACKUP_DIR/"
        mv "$target" "$BACKUP_DIR/"
    fi

    ln -sfn "$src" "$target"
    echo "+ $target → $src"
done <"$SYMLINKS_FILE"

echo "symlinks ok"
