# Global bash customizations that apply to ALL systems.
# Use ~/.bashrc_<domain> or ~/.bashrc_<hostname> for machine-specific bash customizations.

test -z "$PS1" && return  # Bail if not interactive.

PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}:${HOME}/go/bin"

umask 027

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histverify

alias rc='source ${HOME}/.bashrc'

export EDITOR=vim

# Set sorting to bytewise comparison for consistent, predictable ordering.
export LC_COLLATE="C"

# Keep an unlimited bash history.
shopt -s histappend
export HISTSIZE=
export HISTFILESIZE=

# Record timestamps in bash history.
export HISTTIMEFORMAT="%F %H:%M:%S "

# Use a non-standard bash history filename, in case other things try to manipulate the history.
export HISTFILE="${HOME}/.bash_history_full"

# Don't log duplicate commands or commands beginning with a space.
export HISTCONTROL=ignoreboth

# Quick alias for grepping history.
function h() { history | grep "$1" | grep -v "h $1" | tail -n 15; }

# Shortcut to run a `locate` query on a fresh db.
alias loc="echo -n 'running updatedb...';sudo updatedb && echo && locate"

# For temporarily turning off bash history.
incog() {
  export HISTFILE=/dev/null
  export HISTSIZE=0
  export PS1="[history disabled] $PS1"
}

for FILE in \
  "/etc/bash_completion" \
  "${HOME}/.bashrc_$(dnsdomainname -s)" \
  "${HOME}/.bashrc_$(hostname -s)" \
  "${HOME}"/.bash.d/*
  do if [[ -f "${FILE}" ]]; then source "${FILE}"; fi
done
