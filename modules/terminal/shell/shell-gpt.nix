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
  config = lib.mkIf config.cyanea.shell.shell-gpt.enable {
    environment.systemPackages = [
      (pkgs.callPackage (inputs.self + /packages/shell-gpt) {})
    ];
    home-manager.users."${lib.user.name}" = {
      xdg.configFile = {
        "shell_gpt/.sgptrc".source = let
          iniFile = (pkgs.formats.ini {}).generate ".sgptrc" {
            config = {
              CHAT_CACHE_PATH = "/tmp/chat_cache";
              CACHE_PATH = "/tmp/cache";
              CHAT_CACHE_LENGTH = "100";
              CACHE_LENGTH = "100";
              REQUEST_TIMEOUT = "60";
              DEFAULT_MODEL = "ollama/llama3.2:1b";
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
