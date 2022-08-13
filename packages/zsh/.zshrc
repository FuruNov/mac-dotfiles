#!/bin/xsh
# 色を使用出来るようにする
autoload -Uz colors
colors

# vim 風キーバインドにする
bindkey -v

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default

########################################

# 補完機能を有効にする
autoload -Uz compinit
compinit

########################################

# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}

add-zsh-hook precmd _update_vcs_info_msg

########################################

# オプション
setopt print_eight_bit # 日本語ファイル名を表示可能にする
setopt no_beep
setopt no_flow_control
setopt ignore_eof           # Ctrl+Dでzshを終了しない
setopt interactive_comments # '#' 以降をコメントとして扱う
setopt auto_cd              # ディレクトリ名だけでcdする
setopt auto_list            # 補完候補を一覧表示にする
setopt auto_menu            # TAB で順に補完候補を切り替える
setopt auto_pushd           # cd したら自動的にpushdする
setopt pushd_ignore_dups    # 重複したディレクトリを追加しない
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups # 同じコマンドをヒストリに残さない
setopt hist_ignore_space    # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks   # ヒストリに保存するときに余分なスペースを削除する
setopt extended_glob        # 高機能なワイルドカード展開を使用する

# Activate Starship
eval "$(starship init zsh)"

# Activate sheldon(WIP)
# eval "$(sheldon source)"

### Added by Zinit's installer
source <(curl -sL https://git.io/zi-loader)
zzinit

# Load the pure theme, with zsh-async library that's bundled with it.
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

### Lazy load
zinit wait lucid light-mode as'null' \
    atinit'source ~/.zshrc.lazy' \
    for 'zdharma-continuum/null'

zinit wait lucid blockf light-mode for \
    @'zsh-users/zsh-autosuggestions' \
    @'zsh-users/zsh-completions' \
    @'zdharma-continuum/fast-syntax-highlighting' \
    @'zdharma-continuum/history-search-multi-word'
