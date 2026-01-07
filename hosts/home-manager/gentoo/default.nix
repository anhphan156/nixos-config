{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    "${inputs.self}/modules/home-manager/home.nix"
    "${inputs.self}/modules/home-manager/dotfiles/git"
    "${inputs.self}/modules/home-manager/dotfiles/rofi"
    "${inputs.self}/modules/home-manager/dotfiles/tmux"
    # "${inputs.self}/modules/home-manager/dotfiles/fastfetch"
    "${inputs.self}/modules/home-manager/dotfiles/shell/zsh.nix"
    "${inputs.self}/modules/home-manager/dotfiles/shell/starship.nix"
  ];

  # programs.fastfetch.settings.logo = lib.mkForce "${pkgs.wallpapers}/fetch_logo/galaxy.png";

  programs.zsh.shellAliases = {
    "sv" = "sudo /home/${lib.user.name}/.nix-profile/bin/nvim";
  };

  programs.direnv = {
    enable = true;
    silent = true;
  };

  gtk.enable = true;

  gtk.theme.package = pkgs.tokyonight-gtk-theme;
  gtk.theme.name = "Tokyonight-Dark";

  gtk.iconTheme.package = pkgs.paper-icon-theme;
  gtk.iconTheme.name = "Paper";

  home.packages = with pkgs; [
    neovim
    keepassxc
    (callPackage "${inputs.self}/packages/scripts/rofi/text_clipboard.nix" {
      rofiPromptConfig = config.dotfiles.rofi.prompt;
      rofiImgConfig = config.dotfiles.rofi.image;
    })
    (callPackage "${inputs.self}/packages/scripts/media/screenshots.nix" {
      slurp = inputs.image-slurp.packages.${pkgs.system}.default;
    })
    # (callPackage "${inputs.self}/packages/scripts/dev/devgui.nix" {
    #   basePath = lib.user.path.dev;
    #   tmux_code = callPackage "${inputs.self}/packages/scripts/dev/tmux_code_layout.nix" {};
    #   rofiConfig = config.dotfiles.rofi.default;
    # })
    (callPackage "${inputs.self}/packages/scripts/rofi/search_docs.nix" {
      rofiConfig = config.dotfiles.rofi.oneColumn;
    })
  ];
}
