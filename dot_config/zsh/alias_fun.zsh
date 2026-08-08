# ALIASES
alias ...='cd ../..'
alias n='nano'
alias v='nvim'
alias c='clear'
alias e='exit'
if has -q git; then
    alias gl='git log'
    alias ga='git add'
    alias gd='git diff'
    alias gcm='git commit'
    alias gst='git status'
    alias gps='git push'
    alias gpl='git pull'
    alias glg='git log --oneline --graph --decorate --all'
fi
if has -q eza; then
    alias ll='eza -lAg --icons --color --hyperlink --group-directories-first'
    alias l='eza -lA --icons --color --hyperlink --group-directories-first --no-time --no-filesize'
else
    alias ll='ls -lAh --color --hyperlink --group-directories-first'
    alias l='ls -lA --color --hyperlink --group-directories-first --no-group'
fi

# FUNCTIONS
tv() {
    if has tldr fzf; then
        tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,80% | xargs -r tldr
    fi
}
fv() {
    if has fzf fastfetch fd; then
        fd . -e jsonc /usr/share/fastfetch/presets/ | fzf --ansi --preview "fastfetch --config {} --pipe false" --preview-window=right,65% | xargs -r fastfetch --config
    fi
}
pin() {
    if has paru fzf; then
        paru -Ssq "$1" | fzf -m --preview 'paru -Si {}' --preview-window=right,80% | xargs -r paru -S --needed --noconfirm
    fi
}
prm() {
    if has paru fzf; then
        paru -Qeq | fzf -m --preview 'paru -Qi {}' --preview-window=right,80% | xargs -r paru -Rns --noconfirm
    fi
}
aus() {
    if has curl jq; then
        curl -s "https://aur.archlinux.org/rpc/v5/search/$1" | \
        jq --argjson threshold "$(date -d '1 year ago' +%s)" \
            '.results
            | map(select(.LastModified >= $threshold))
            | sort_by(-.LastModified)
            | .[]
            | { Name, Description, URL,
                FirstSubmitted: (.FirstSubmitted | strftime("%Y-%m-%d")),
                LastModified: (.LastModified | strftime("%Y-%m-%d")),
                Version }'
    fi
}
lg() {
    if [[ "$1" == "-u" || "$1" == "--user" ]]; then
        shift
        journalctl --user -feu "$@"
    else
        journalctl -feu "$@"
    fi
}
