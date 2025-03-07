{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      scan_timeout = 10;
      format = lib.concatStrings [
        "[➜](bold green) $directory$c$rust$nix_shell$os"
        "$line_break"
        "$character"
      ];
      # format = lib.concatStrings [
      #   "╭───── $directory$c$rust$nix_shell$os"
      #   "$line_break"
      #   "╰──$character"
      # ];
      right_format = lib.concatStrings [
        "$git_branch$git_status"
      ];
      character = {
        success_symbol = "[↪](bold white)";
        error_symbol = "[↪](bold red)";
        vimcmd_symbol = "[󰕷](bold white)";
      };
      hostname = {
        ssh_only = false;
        format = lib.concatStrings [
          "[$hostname](bold green)"
        ];
      };
      username = {
        show_always = true;
        format = "[$user](bold green)";
      };
      os = {
        disabled = false;
        format = "[$symbol]($style)";
        style = "bold white";
      };
      git_branch = {
        symbol = " ";
        style = "bold purple";
        format = "[$symbol$branch]($style)";
      };
    };
  };
}
