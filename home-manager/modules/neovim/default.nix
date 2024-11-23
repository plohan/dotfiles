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
        plugin = kanagawa-nvim;
        config = "colorscheme kanagawa";
      }

      {
        plugin = lualine-nvim;
        config = toLuaFile ./lualine.lua;
      }

      {
        plugin = nvim-cmp;
        config = toLuaFile ./cmp.lua;
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./lsp.lua;
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      vim-vsnip
      cmp-vsnip

      {
        plugin = telescope-nvim;
        config = toLuaFile ./telescope.lua;
      }
      plenary-nvim

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
    '';
  };
}
