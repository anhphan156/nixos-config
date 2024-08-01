{
  user,
  lib,
  ...
}: {
  home-manager.users."${user.name}" = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        scan_timeout = 10;
        format = lib.concatStrings [
          "╭───── $directory$os$c$rust$nix_shell"
					"$line_break"
					"╰──$character"
        ];
        right_format = lib.concatStrings [
          "$git_branch$git_status"
        ];
        character = {
          success_symbol = "[](bold white)";
          error_symbol = "[](bold red)";
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
  };
}
