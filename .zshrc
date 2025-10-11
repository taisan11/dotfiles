# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
# if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#   source /usr/share/zsh/manjaro-zsh-config
# fi
# Use manjaro zsh prompt
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi

# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# plugins=(
# git
# zsh-syntax-highlighting
# zsh-autosuggestions
# history-substring-search
# )

# source $ZSH/oh-my-zsh.sh
autoload -Uz compinit
compinit
function source {
  ensure_zcompiled $1
  builtin source $1
}
function ensure_zcompiled {
  local compiled="$1.zwc"
  if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
    # echo "Compiling $1"
    zcompile $1
  fi
}
ensure_zcompiled ~/.zshrc

# ファイル名を変数に入れる
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$HOME/.config/sheldon/plugins.toml"
# キャッシュがない、またはキャッシュが古い場合にキャッシュを作成
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $cache_dir
  sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
# 使い終わった変数を削除
unset cache_dir sheldon_cache sheldon_toml

alias slmugen='while true
do
  sl
done
'
eval "$(~/.local/bin/mise activate zsh)"

# pnpm
export PNPM_HOME="/home/taisan11/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
eval "$(uv generate-shell-completion zsh)"
export PATH="/home/taisan11/.cache/.bun/bin:$PATH"
export custom_vroot="/home/taisan11/.local/share/mise/installs/asdf-mise-plugins-mise-v/latest"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# 履歴conifg
# 履歴ファイルの場所
HISTFILE=~/.zsh_history

# 履歴の保存数
HISTSIZE=10000
SAVEHIST=10000

# よく使うオプション
setopt hist_ignore_dups      # 同じコマンドは重複保存しない
setopt share_history         # 複数のzsh間で履歴を共有
setopt append_history        # 履歴を上書きせず追加する
setopt inc_append_history    # コマンド実行ごとに即座に履歴ファイルへ追加

bindkey '^[[1;5D' backward-word  # Ctrl + 左矢印
bindkey '^[[1;5C' forward-word   # Ctrl + 右矢印
