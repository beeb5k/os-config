{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      share = false;
      # size = 10000;
      save = 10000;
    };

    # Initialize Zinit and add it to ZSH
    initExtra = ''
      # Install Zinit if not already installed
      if [[ ! -d $HOME/.zinit/bin ]]; then
        mkdir -p $HOME/.zinit
        git clone https://github.com/zdharma-continuum/zinit.git $HOME/.zinit/bin
      fi

      # ---- Source Zinit ----
      source $HOME/.zinit/bin/zinit.zsh

      # ---- Plugins ----
      zinit ice depth=1; zinit light romkatv/powerlevel10k

      zinit ice wait"1" lucid
      zinit light zsh-users/zsh-syntax-highlighting
      zinit light zsh-users/zsh-autosuggestions

      zinit ice wait"2" lucid
      zinit light zsh-users/zsh-history-substring-search
      zinit light Aloxaf/fzf-tab
      zinit light joshskidmore/zsh-fzf-history-search
      zinit light mrjohannchang/zsh-interactive-cd

      zinit ice wait"3" lucid
      zinit light zsh-users/zsh-completions

      # ---- load p10k theme ----
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # ---- Keybindings ----
      bindkey '^[[1;5D' backward-word  # Ctrl + Left Arrow → Move one word left
      bindkey '^[[1;5C' forward-word   # Ctrl + Right Arrow → Move one word right

      bindkey '^H' backward-kill-word  # Ctrl + Backspace → Delete whole word left
      bindkey '^[[3;5~' kill-word      # Ctrl + Delete → Delete whole word right

      bindkey '^[[C' forward-char     # Right Arrow → Move right normally
      bindkey '^E' end-of-line        # Ctrl + E → Accept auto-suggestion

      # ---- Completion settings ----
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' menu select

      setopt nocaseglob    # Case insensitive globbing
      setopt correct       # Auto correct mistakes
    '';

    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch";
    };
  };
}
