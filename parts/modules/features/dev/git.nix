{
  flake.nixosModules.git = {config, ...}: {
    programs.git = {
      enable = true;
      lfs.enable = true;
      config = {
        user.name = config.constants.gitname;
        user.email = config.constants.gitemail;
        alias = {
          # common aliases
          br = "branch";
          co = "checkout";
          st = "status";
          ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
          ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
          cm = "commit -m";
          dc = "diff --cached";
          amend = "commit --amend --no-edit";

          # aliases for submodule
          # update = "submodule update --init --recursive";
          # foreach = "submodule foreach";
        };
        pull.rebase = true;
      };

      # includes = [
      #   {
      #     # use diffrent email & name for work
      #     path = "~/work/.gitconfig";
      #     condition = "gitdir:~/work/";
      #   }
      # ];
    }; # git
  };
}
