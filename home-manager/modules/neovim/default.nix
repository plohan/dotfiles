{ pkgs, inputs, ... }:

{
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    viAlias = true;
    vimAlias = true;

    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./treesitter.lua;
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          pname = "challenger-deep";
          src = inputs.challenger-deep;
          version = "2024-12-27";
        };
        config = "colorscheme challenger_deep";
      }

      {
        plugin = gruvbox;
        config = "colorscheme gruvbox";
      }

      # {
      #   plugin = kanagawa-nvim;
      #   config = "colorscheme kanagawa";
      # }

      {
        plugin = lualine-nvim;
        config = toLuaFile ./lualine.lua;
      }

      {
        plugin = blink-cmp;
        config = toLuaFile ./blink-cmp.lua;
      }

      # {
      #   plugin = nvim-cmp;
      #   config = toLuaFile ./cmp.lua;
      # }
      # cmp-nvim-lsp
      # cmp-buffer
      # cmp-path
      # cmp-cmdline
      # vim-vsnip
      # cmp-vsnip

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./lsp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./telescope.lua;
      }
      plenary-nvim

      vim-fugitive

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          pname = "cellular-automaton";
          src = inputs.cellular-automaton;
          version = "2024-05-14";
        };
        config = toLuaFile ./fml.lua;
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./keymap.lua}
      ${builtins.readFile ./tsrename.lua}
    '';
  };
}
