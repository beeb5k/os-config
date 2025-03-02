{...}: {
  programs.zsh = {
    enable = true;
    profileExtra = ''
      setopt NO_CASE_GLOB
    '';

    initExtra = ''
      # Add any custom Zsh settings here
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY
      export PATH="$HOME/.local/bin:$PATH"
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zsh-users/zsh-completions";}
        {name = "marlonrichert/zsh-autocomplete";}
        {name = "zsh-users/zsh-syntax-highlighting";}
        {name = "mrjohannchang/zsh-interactive-cd";}
        {name = "joshskidmore/zsh-fzf-history-search";}
        {name = "romkatv/powerlevel10k";}
      ];
    };

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /etc/nixos#default";
      update-user = "home-manager switch --flake ~/.config/home-manager#beeb5k";
    };
  };
}
