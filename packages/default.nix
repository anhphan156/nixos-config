{
  user,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./fonts
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    cmake
    gnumake
    curl
    gcc
    inputs.alejandra.defaultPackage.${pkgs.system}
  ];

  home-manager.users."${user.name}" = {

        nixpkgs.config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };

		home.packages = with pkgs; [
    obsidian
    cinnamon.nemo
    pureref

    cmatrix
    fastfetch
    bunnyfetch
    pamixer
    fzf
    xclip
    bat
    maim
    bc
    id3v2
    xdotool
    nix-prefetch-git
    #(ffmpeg.override { withXcb = true; })
    unzip
    fortune
    jq
    btop
    lolcat
    asciiquarium
    cbonsai
    figlet
    acpid
    mpv
    cava

    blender
    obs-studio

    ghc
    valgrind
    gdb

    (import ./user_scripts/search_docs.nix {inherit pkgs;})
    (import ./user_scripts/tmux_code_layout.nix {inherit pkgs;})
    (import ./user_scripts/kitty_spawn/spawn_tmux_code.nix {inherit pkgs;})
  ];
	};
}
