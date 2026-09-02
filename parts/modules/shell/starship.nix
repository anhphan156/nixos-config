{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.modules.nixos.shell = moduleWithSystem (
    { self', ... }: {
      programs.starship = {
        enable = true;
        package = self'.packages.starship;
      };
    }
  );

  perSystem =
    {
      lib,
      pkgs,
      ...
    }:
    {
      packages.starship =
        (inputs.wrappers.wrapperModules.starship.apply {
          inherit pkgs;

          settings = {
            add_newline = true;
            scan_timeout = 10;
            format = lib.concatStrings [
              "[➜](bold green) $directory, $hostname, $c$rust$nix_shell$os"
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
            directory = {
              format = "[$path]($style)[$read_only]($read_only_style)";
            };
            hostname = {
              ssh_only = false;
              format = lib.concatStrings [
                "[$hostname](bold cyan)"
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
        }).wrapper;
    };
}
