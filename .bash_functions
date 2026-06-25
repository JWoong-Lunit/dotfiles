# Shell functions — sourced from .bashrc

# === directory bookmarks ===
export MARKPATH=$HOME/.marks

mark() {
    mkdir -p "$MARKPATH"
    echo "$(pwd)" > "$MARKPATH/$1"
    echo "Marked: $1 → $(pwd)"
}

jump() {
    local target
    target=$(cat "$MARKPATH/$1" 2>/dev/null)
    if [ -z "$target" ]; then
        echo "No mark: $1"
        return 1
    fi
    cd "$target" || return 1
}

marks() {
    for f in "$MARKPATH"/*; do
        [ -e "$f" ] || continue
        printf "%-15s → %s\n" "$(basename "$f")" "$(cat "$f")"
    done
}

unmark() {
    rm -f "$MARKPATH/$1"
    echo "Removed: $1"
}

# tab-complete mark names for jump/unmark
_marks_complete() {
    COMPREPLY=($(compgen -W "$(ls "$MARKPATH" 2>/dev/null)" -- "${COMP_WORDS[1]}"))
}
complete -F _marks_complete jump unmark

# === utils ===
# Top 20 largest items under given dir (default: cwd)
ducks() { du -sh "${1:-.}"/* | sort -rh | head -20; }
