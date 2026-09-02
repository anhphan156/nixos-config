{
  symlinkJoin,
  neovim,
  makeWrapper,
  lua-language-server,
  nixd,
  nixfmt,
  git,
  openssh,
  wl-clipboard,
  ripgrep,
  curl,
  tree-sitter,
  tmux,
  nvimInit,
  nvimConfig,
  nvimSnippets,
  vimPlugins,
  runCommandLocal,
  lib,
  ...
}:
let
  packageName = "NvimPlugins";

  startPlugins = with vimPlugins; [
    (
      let
        luaEnv = neovim.lua.withPackages (
          luaPackages: with luaPackages; [
            magick
          ]
        );
        inherit (neovim.lua.pkgs.luaLib) genLuaPathAbsStr genLuaCPathAbsStr;
      in
      runCommandLocal "init-plugin" { } ''
        mkdir -pv $out/plugin
        tee $out/plugin/init.lua <<EOF
        package.path = "${genLuaPathAbsStr luaEnv};" .. package.path
        package.cpath = "${genLuaCPathAbsStr luaEnv};" .. package.cpath
        EOF
      ''
    )

    bufferline-nvim
    snacks-nvim
    nvim-web-devicons
    nvim-notify
    noice-nvim

    telescope-nvim
    telescope-file-browser-nvim
    telescope-project-nvim
    nvim-treesitter.withAllGrammars
    gitsigns-nvim
    presence-nvim
    lz-n
    startup-nvim
    vim-tmux-navigator
    direnv-vim

    tokyonight-nvim

    nvim-lspconfig
    lsp-format-nvim
    lspkind-nvim
    lspsaga-nvim

    nvim-cmp
    cmp-nvim-lsp
    cmp-path
    cmp-buffer
    cmp_luasnip
    luasnip

    mini-nvim
    mini-pairs
  ];

  optPlugins = with vimPlugins; [
    neogit
    nvim-tree-lua
    leetcode-nvim
    image-nvim
  ];

  foldPlugins = builtins.foldl' (acc: x: acc ++ [ x ] ++ foldPlugins (x.dependencies or [ ])) [ ];

  startPluginsWithDeps = lib.unique <| foldPlugins startPlugins;
  optPluginsWithDeps = lib.unique <| foldPlugins optPlugins;

  otherDeps = lib.makeBinPath [
    lua-language-server
    nixd
    nixfmt
    # vscode-langservers-extracted
    # llvmPackages_19.clang-tools
    # glsl_analyzer
    # haskell-language-server
    # stack
    # rust-analyzer
    # cargo
    # rustc
    # ghc
    # gcc
    tree-sitter
    git
    openssh
    wl-clipboard
    ripgrep
    curl
    tmux
  ];

  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ln -vsfT ${nvimConfig} $out/pack/${packageName}/start/myConfig
    ${lib.concatMapStringsSep "\n" (
      x: "ln -vsfT ${x} $out/pack/${packageName}/start/${lib.getName x}"
    ) startPluginsWithDeps}
    ${lib.concatMapStringsSep "\n" (
      x: "ln -vsfT ${x} $out/pack/${packageName}/opt/${lib.getName x}"
    ) optPluginsWithDeps}
  '';
in
symlinkJoin {
  name = "nvim";
  paths = [ neovim ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/nvim \
    	--add-flags '-u' \
    	--add-flags '${nvimInit}' \
    	--add-flags '--cmd' \
    	--add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
    	--set-default NVIM_APPNAME nvim-custom \
      --suffix PATH : ${otherDeps} \
    	--set SNIPPETS ${nvimSnippets}
  '';
}
