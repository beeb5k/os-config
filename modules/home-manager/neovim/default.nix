{
  config,
  lib,
  inputs,
  ...
}: let
  utils = inputs.nixCats.utils;
in {
  imports = [
    inputs.nixCats.homeModule
  ];
  config = {
    nixCats = {
      enable = true;
      nixpkgs_version = inputs.nixpkgs;
      # this will add the overlays from ./overlays and also,
      # add any plugins in inputs named "plugins-pluginName" to pkgs.neovimPlugins
      # It will not apply to overall system, just nixCats.
      addOverlays =
        /*
        (import ./overlays inputs) ++
        */
        [
          (utils.standardPluginOverlay inputs)
        ];
      # see the packageDefinitions below.
      # This says which of those to install.
      packageNames = ["Neovim"];

      luaPath = ./.;

      # the .replace vs .merge options are for modules based on existing configurations,
      # they refer to how multiple categoryDefinitions get merged together by the module.
      # for useage of this section, refer to :h nixCats.flake.outputs.categories
      categoryDefinitions.replace = {
        pkgs,
        settings,
        categories,
        extra,
        name,
        mkNvimPlugin,
        ...
      } @ packageDef: {
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            ripgrep
            fd # Telescope deps
          ];
        };
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            lze
            mini-base16
            lualine-nvim
            nvim-treesitter.withAllGrammars
            gitsigns-nvim
            which-key-nvim
          ];
        };
        optionalPlugins = {
          general = with pkgs.vimPlugins; [
            telescope-nvim
            nvim-autopairs
            auto-save-nvim
          ];
        };
        # shared libraries to be added to LD_LIBRARY_PATH
        # variable available to nvim runtime
        sharedLibraries = {
          general = with pkgs; [
            # libgit2
          ];
        };
        environmentVariables = {
        };
        extraWrapperArgs = {
        };
        # lists of the functions you would have passed to
        # python.withPackages or lua.withPackages

        # get the path to this python environment
        # in your lua config via
        # vim.g.python3_host_prog
        # or run from nvim terminal via :!<packagename>-python3
        extraPython3Packages = {
          test = _: [];
        };
        # populates $LUA_PATH and $LUA_CPATH
        extraLuaPackages = {
          test = [(_: [])];
        };
      };

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions.replace = {
        # These are the names of your packages
        # you can include as many as you wish.
        Neovim = {pkgs, ...}: {
          # they contain a settings set defined above
          # see :help nixCats.flake.outputs.settings
          settings = {
            wrapRc = true;
            # IMPORTANT:
            # your alias may not conflict with your other packages.
            aliases = ["vim" "nvim" "vi" "v" "nv"];
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
          };
          extra = {
            base16colors =
              pkgs.lib.filterAttrs (
                k: v:
                  builtins.match "base0[0-9A-F]" k != null
              )
              config.lib.stylix.colors.withHashtag;
          };
          # and a set of categories that you want
          # (and other information to pass to lua)
          categories = {
            general = true;
            test = true;
          };
        };
      };
    };
  };
}
