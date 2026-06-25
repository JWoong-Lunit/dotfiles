# === Core ===
case $- in *i*) ;; *) return;; esac  # exit if non-interactive

# === History ===
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%F %T '              # timestamps in `history`
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar    # ** matches recursively
shopt -s cdspell     # autocorrect minor cd typos
shopt -s autocd      # `cd` into a dir by typing its name
PROMPT_COMMAND='history -a'          # flush history so parallel shells don't clobber

# === Prompt ===
MY_EMOJI=(😠 😆 🤣 😎 🤗 😴 😵 😡 🧡 🤨 🤢 😈 🤬 😤 🤟 🤯 🧐)
get_random_emoji() { echo ${MY_EMOJI[$((RANDOM%${#MY_EMOJI[@]}))]}; }

parse_git_branch() { git rev-parse --abbrev-ref HEAD 2>/dev/null; }

PS1=' $(get_random_emoji) \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\e[33m\][$(parse_git_branch)]\[\e[0m\]\$ '

# === Colors ===
eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# === Completion ===
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
fi

# === mise ===
if command -v mise &>/dev/null; then
    eval "$(mise activate bash)"
fi

# === Extras ===
[ -f ~/.bash_aliases ]   && source ~/.bash_aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions
[ -f ~/.bashrc.secrets ] && source ~/.bashrc.secrets    # secrets, gitignored
