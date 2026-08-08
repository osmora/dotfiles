has() {
    typeset quiet=false
    typeset OPTIND opt cmd

    while getopts ":q" opt; do
        case "$opt" in
            q)
                quiet=true
            ;;
            \?)
                echo "Error: Invalid option: -$OPTARG" >&2
                return 1
            ;;
        esac
    done

    shift $((OPTIND - 1))

    if [[ $# -eq 0 ]]; then
        if ! $quiet; then
            echo "Error: No pkgs specified for checking." >&2
            return 1
        else
            return 1
        fi
    fi

    for cmd in "$@"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            if ! $quiet; then
                echo "Error: '$cmd' is not installed, please install it." >&2
                return 1
            else
                return 1
            fi
        fi
    done
}

set_editor() {
    typeset editor

    for editor in nvim vim nano vi; do
        if has -q "$editor"; then
            typeset -gx EDITOR="$editor"
            typeset -gx VISUAL="$editor"
            return
        fi
    done
}
set_editor
