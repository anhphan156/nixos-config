{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    extraConfig = ''
      set-option -g cursor-style underline
      set-option -g default-terminal "tmux-256color"
      set-option -ga update-environment TERM
      set-option -ga update-environment TERM_PROGRAM
      set-option -g allow-passthrough on
    '';

    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
  };
}
