{
  pkgs,
  inputs,
  lib,
  ...
}:
pkgs.testers.runNixOSTest {
  name = "LiveUsbTest";
  nodes = {
    machine = args: {
      imports = let
        overrideLib = path: let
          fn = import path;
        in
          if builtins.isFunction fn
          then
            fn (args
              // {
                inherit inputs pkgs lib;
              })
          else fn;

        otherModules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nixvim.nixosModules.nixvim
          inputs.xremap.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.dotfiles.nixosModules.default
        ];

        myModules =
          [
            (inputs.self + /packages)
            (inputs.self + /hosts/linux/liveusb)
          ]
          ++ (lib.getNixFiles (inputs.self + /modules));
      in
        map overrideLib myModules ++ otherModules;
    }; # machines
  }; # nodes

  testScript = let
    script = pkgs.writeShellApplication {
      name = "TestScript";
      text = ''
        which disko
        ls ~/disko-repo/example

        which pacstrap

        fc-list | grep -i anka
      '';
    };
  in ''
    machine.wait_for_unit("default.target")
    machine.succeed("su -- ${lib.user.name} -c '${lib.getExe script}'")
    machine.succeed("pacman-key-init")
  '';
}
