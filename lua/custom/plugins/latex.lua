-- ~/.config/nvim/lua/custom/plugins/latex.lua

return {
  -- VimTeX for LaTeX support
  {
    'lervag/vimtex',
    lazy = false, -- Don't lazy load VimTeX
    init = function()
      -- PDF viewer settings
      -- vim.g.vimtex_view_method = 'zathura' -- Linux
      vim.g.vimtex_view_method = 'skim' -- macOS
      -- vim.g.vimtex_view_method = 'sioyek' -- Cross-platform alternative

      -- Compiler settings
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_compiler_latexmk = {
        build_dir = '', -- Build in same directory initially
        callback = 1,
        continuous = 1,
        executable = 'latexmk',
        options = {
          '-pdf',
          '-verbose',
          '-file-line-error',
          '-synctex=1',
          '-interaction=nonstopmode',
        },
      }

      -- Better main file detection
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = '-pdf',
      }

      -- Enable main file detection logging (temporary for debugging)
      vim.g.vimtex_log_verbose = 1

      -- Don't open quickfix automatically
      vim.g.vimtex_quickfix_mode = 0

      -- Syntax concealing for cleaner math display
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 0,
        styles = 1,
      }

      -- Note: syntax_conceal_default is deprecated in newer VimTeX versions
      -- Concealing is now controlled by the syntax_conceal table above
    end,
  },

  -- Enhanced snippet support for LaTeX
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local ls = require 'luasnip'

      -- Load snippets from friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Load custom LaTeX snippets
      require('luasnip.loaders.from_lua').lazy_load {
        paths = vim.fn.stdpath 'config' .. '/lua/custom/snippets/',
      }

      -- Key mappings for snippets
      vim.keymap.set({ 'i', 's' }, '<C-k>', function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ 'i', 's' }, '<C-j>', function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },
}
