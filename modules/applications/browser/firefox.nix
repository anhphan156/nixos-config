{
  lib,
  pkgs,
  config,
  user,
  inputs,
  ...
}: let
  cfg = config.cyanea.desktopApp.firefox;
  cfggui = config.cyanea.graphical.gui;
in {
  options = {
    cyanea.desktopApp.firefox.enable = lib.mkEnableOption "Enable Firefox";
    cyanea.desktopApp.firefox.spacebar.enable = lib.mkEnableOption "Enable Spacebar profile for firefox";
  };

  config = lib.mkIf (cfggui.enable && cfg.enable) {
    home-manager.users."${user.name}" = {
      home.packages = lib.mkIf cfg.spacebar.enable [
        (pkgs.writeShellScriptBin "ffspacebar" ''
          firefox -P spacebar
        '')
      ];

      programs.firefox = {
        enable = true;
        policies = {
          NoDefaultBookmarks = true;
					"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        profiles.spacebar = lib.mkIf cfg.spacebar.enable {
          name = "spacebar";
          id = 1;
          search = {
            force = true;
            default = "DuckDuckGo";
          };
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            ublock-origin
          ];
          # containers = {
          # 	education = {
          # 		name = "education";
          # 		id = 1;
          # 		color = "blue";
          # 		icon = "tree";
          # 	};
          # 	job = {
          # 		name = "job";
          # 		id = 2;
          # 		color = "orange";
          # 		icon = "briefcase";
          # 	};
          # };
        };
        profiles."${user.name}" = {
          name = user.name;
          isDefault = true;
          search = {
            force = true;
            default = "DuckDuckGo";
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = ["@np"];
              };
              "NixOS Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "from";
                        value = "0";
                      }
                      {
                        name = "size";
                        value = "50";
                      }
                      {
                        name = "sort";
                        value = "relevance";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = ["@no"];
              };
              "HomeManager Options" = {
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com";
                    params = [
                      {
                        name = "release";
                        value = "master";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = ["@hm"];
              };
              "Hoogle" = {
                urls = [
                  {
                    template = "https://hoogle.haskell.org/";
                    params = [
                      {
                        name = "hoogle";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = ["@hg"];
              };
            };
          };
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            ublock-origin
          ];
          #bookmarks = [
          #    {
          #        name = "Nix Packages";
          #        tags = ["nix"];
          #        keyword = "nixpkgs";
          #        url = "https://search.nixos.org/packages";
          #    }
          #    {
          #        name = "NixOS Options";
          #        tags = ["nix"];
          #        keyword = "nixosoptions";
          #        url = "https://search.nixos.org/options";
          #    }
          #    {
          #        name = "HomeManager Options";
          #        tags = ["home-manager"];
          #        keyword = "home-manager";
          #        url = "https://home-manager-options.extranix.com/";
          #    }
          #    #{
          #    #    name = "";
          #    #    tags = [""];
          #    #    keyword = "";
          #    #    url = "";
          #    #}
          #];
        };
      };
    };
  };
}
