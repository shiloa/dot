#!/bin/bash
set -e

echo "🚀 Starting Bash Environment Setup..."

# 1. Install Homebrew if missing
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Install Core Tools
echo "📦 Installing tools via Homebrew..."
brew install starship fzf bash-completion@2 gawk direnv pyenv nodenv zoxide

# 3. Install ble.sh (The Magic)
if [ ! -f "$HOME/.local/share/blesh/ble.sh" ]; then
    echo "✨ Installing ble.sh (Autosuggestions)..."
    rm -rf ble.sh-tmp
    git clone --recursive https://github.com/akinomyoga/ble.sh.git ble.sh-tmp
    make -C ble.sh-tmp install PREFIX=~/.local
    rm -rf ble.sh-tmp
    echo "✅ ble.sh installed!"
else
    echo "✨ ble.sh already installed."
fi

# 4. Symlink Configuration Files
# Gets the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🔗 Symlinking config files from $DOTFILES_DIR..."

backup_and_link() {
    local src="$1"
    local dest="$2"
    
    if [ -f "$dest" ] && [ ! -L "$dest" ]; then
        echo "   Backing up existing $dest to ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi
    
    # Force link (ln -sf)
    ln -sf "$src" "$dest"
    echo "   Linked $dest -> $src"
}

backup_and_link "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
backup_and_link "$DOTFILES_DIR/.inputrc" "$HOME/.inputrc"

mkdir -p "$HOME/.config"
backup_and_link "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

echo "🎉 Setup Complete! Restart your terminal or run 'exec bash'"
