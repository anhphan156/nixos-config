{lib, ...}: {
  programs.git = {
    enable = true;

    lfs = lib.enabled;

    settings = {
      user.name = lib.user.git_name;
      user.email = lib.user.git_email;
      alias = {
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
      pull.rebase = true;
    };

    # includes = [
    #   {
    #     # use diffrent email & name for work
    #     path = "~/work/.gitconfig";
    #     condition = "gitdir:~/work/";
    #   }
    # ];
  };
}
