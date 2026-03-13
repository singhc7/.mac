return {
  {
    'wincent/base16-nvim',
    lazy = false, -- load at start
    priority = 1000, -- load first
    config = function()
      vim.cmd [[colorscheme gruvbox-dark-hard]]
      vim.o.background = 'dark'
      vim.cmd [[hi Normal ctermbg=NONE]]
      -- Less visible window separator
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 1250067 })
      -- Make comments more prominent -- they are important.
      local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
      vim.api.nvim_set_hl(0, 'Comment', bools)
      -- Make it clearly visible which argument we're at.
      local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
      vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', {
        fg = marked.fg,
        bg = marked.bg,
        ctermfg = marked.ctermfg,
        ctermbg = marked.ctermbg,
        bold = true,
      })
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = { signs = false },
  },

  -- nice bar at the bottom
  {
    'itchyny/lightline.vim',
    lazy = false, -- also load at start since it's UI
    config = function()
      -- no need to also show mode in cmd line when we have bar
      vim.o.showmode = false
      vim.g.lightline = {
        active = {
          left = {
            { 'mode', 'paste' },
            { 'readonly', 'filename', 'modified' },
          },
          right = {
            { 'lineinfo' },
            { 'percent' },
            { 'fileencoding', 'filetype' },
          },
        },
        component_function = {
          filename = 'LightlineFilename',
        },
      }
      function _G.LightlineFilenameInLua(opts)
        if vim.fn.expand '%:t' == '' then
          return '[No Name]'
        else
          return vim.fn.getreg '%'
        end
      end
      -- https://github.com/itchyny/lightline.vim/issues/657
      vim.api.nvim_exec(
        [[
				function! g:LightlineFilename()
					return v:lua.LightlineFilenameInLua()
				endfunction
				]],
        true
      )
    end,
  },

  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings
      require('mini.surround').setup()
    end,
  },
}
