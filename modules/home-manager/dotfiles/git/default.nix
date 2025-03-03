{lib, ...}: {
  programs.git = {
    enable = true;
    userName = lib.user.git_name;
    userEmail = lib.user.git_email;

    # includes = [
    #   {
    #     # use diffrent email & name for work
    #     path = "~/work/.gitconfig";
    #     condition = "gitdir:~/work/";
    #   }
    # ];

    extraConfig = {
      pull.rebase = true;
    };

    aliases = {
      # common aliases
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      # amend = "commit --amend -m";

      # aliases for submodule
      # update = "submodule update --init --recursive";
      # foreach = "submodule foreach";
    };
  };
}
