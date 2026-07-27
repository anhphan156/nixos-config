{
  flake.nixosModules.zsh = {
    config,
    pkgs,
    ...
  }: {
    users.users."${config.constants.username}".shell = pkgs.zsh;
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      histFile = "$HOME/.local/share/zsh/zsh_history";

      interactiveShellInit = ''
        export ZSHZ_DATA="$HOME/.local/share/zsh/.z";
      '';

      shellAliases = {
        "v" = " nvim";
        "mpv" = " mpv --vo=kitty --vo-kitty-use-shm=yes";
        "exit" = " exit";
        "leet" = " nvim +Leet";
      };

      ohMyZsh = {
        enable = true;
        plugins = ["git" "z" "vi-mode"];
      };



    };
  };
}
