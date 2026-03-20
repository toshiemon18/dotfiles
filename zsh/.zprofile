# ---------------------------
# PATH
# ---------------------------

# macOS system path
eval "$(/usr/libexec/path_helper)"

# Homebrew (Apple Silicon: /opt/homebrew, Intel: /usr/local)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Local user bin
export PATH="$HOME/.local/bin:$PATH"

# ---------------------------
# Tool activation
# ---------------------------

# mise (runtime version manager)
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh --shims)"
fi

# ---------------------------
# Machine-specific overrides
# ---------------------------
# Put machine-local settings (e.g. JetBrains Toolbox, company tools) here:
#   ~/.zprofile.local
[ -f ~/.zprofile.local ] && source ~/.zprofile.local
