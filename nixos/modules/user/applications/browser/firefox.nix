{ lib, config, user, inputs, ... }:
{
    options = {
        firefox.enable = lib.mkEnableOption "Enable Firefox";
    };
    config = lib.mkIf (config.gui.enable && config.firefox.enable) {
        home-manager.users."${user.name}".programs.firefox = {
            enable = true;
            policies = {
                NoDefaultBookmarks = true;
            };
            profiles.backspace = {
                name = "backspace";
                search = {
                    force = true;
                    
                    engines = {
                        "Nix Packages" = {
                            urls = [{
                                template = "https://search.nixos.org/packages";
                                params = [
                                    { name = "type"; value = "packages"; }
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }];
                            definedAliases = [ "@np" ];
                        };
                        "NixOS Options" = {
                            urls = [{
                                template = "https://search.nixos.org/options";
                                params = [
                                    { name = "channel"; value = "unstable"; }
                                    { name = "type"; value = "packages"; }
                                    { name = "from"; value = "0"; }
                                    { name = "size"; value = "50"; }
                                    { name = "sort"; value = "relevance"; }
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }];
                            definedAliases = [ "@no" ];
                        };
                        "HomeManager Options" = {
                            urls = [{
                                template = "https://home-manager-options.extranix.com";
                                params = [
                                    { name = "release"; value = "master"; }
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }];
                            definedAliases = [ "@hm" ];
                        };
                        "Hoogle" = {
                            urls = [{
                                template = "https://hoogle.haskell.org/";
                                params = [
                                    { name = "hoogle"; value = "{searchTerms}"; }
                                ];
                            }];
                            definedAliases = [ "@hg" ];
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
}
