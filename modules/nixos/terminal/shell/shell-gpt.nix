{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.cyanea.shell.shell-gpt = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf (config.cyanea.shell.shell-gpt.enable && config.cyanea.services.ollama.enable) {
    environment.systemPackages = [
      (pkgs.callPackage (inputs.self + /packages/shell-gpt) {})
    ];
    home-manager.users."${lib.user.name}" = {
      programs.zsh = {
        initContent = lib.mkBefore ''
          # Shell-GPT integration ZSH v0.2
          _sgpt_zsh() {
          if [[ -n "$BUFFER" ]]; then
              _sgpt_prev_cmd=$BUFFER
              BUFFER+="⌛"
              zle -I && zle redisplay
              BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
              zle end-of-line
          fi
          }
          zle -N _sgpt_zsh
          bindkey ^l _sgpt_zsh
          # Shell-GPT integration ZSH v0.2
        '';
      };

      xdg.configFile = {
        "shell_gpt/.sgptrc".source = let
          iniFile = (pkgs.formats.ini {}).generate ".sgptrc" {
            config = {
              CHAT_CACHE_PATH = "/tmp/chat_cache";
              CACHE_PATH = "/tmp/cache";
              CHAT_CACHE_LENGTH = "100";
              CACHE_LENGTH = "100";
              REQUEST_TIMEOUT = "60";
              DEFAULT_MODEL = "ollama/${config.cyanea.services.ollama.startupModel}";
              DEFAULT_COLOR = "magenta";
              ROLE_STORAGE_PATH = "/home/${lib.user.name}/.config/shell_gpt/roles";
              DEFAULT_EXECUTE_SHELL_CMD = "false";
              DISABLE_STREAMING = "false";
              CODE_THEME = "dracula";
              OPENAI_FUNCTIONS_PATH = "/home/${lib.user.name}/.config/shell_gpt/functions";
              OPENAI_USE_FUNCTIONS = "false";
              SHOW_FUNCTIONS_OUTPUT = "false";
              API_BASE_URL = "default";
              PRETTIFY_MARKDOWN = "true";
              USE_LITELLM = "true";
              SHELL_INTERACTION = "true";
              OS_NAME = "auto";
              SHELL_NAME = "auto";
              OPENAI_API_KEY = "haha";
            };
          };
        in
          pkgs.runCommandLocal ".sgptrc" {} ''
            sed '1d' ${iniFile} > $out
          '';
      };
    };
  };
}
