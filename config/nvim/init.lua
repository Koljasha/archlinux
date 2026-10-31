-- ~/.config/nvim/init.lua

-- Базовые настройки (VimScript)
vim.cmd('source ~/.config/vim/settings.vim')

-- Привязки клавиш
vim.cmd('source ~/.config/vim/mappings.vim')

-- Терминал и Проводник
vim.cmd('source ~/.config/vim/explorers.vim')

-- Только Nvim (в vim такого нет):
-- колонка знаков всегда видима, текст не прыгает
vim.opt.signcolumn = 'yes'
-- отзывчивость CursorHold и диагностики (дефолт 4000)
vim.opt.updatetime = 300

-- Установка lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Подхватываем vim-плагины из общего каталога (~/.vim/plugged).
-- Скан обязателен: lazy сам source'ит plugin/*.vim, а rtp от vim-plug
-- в nvim появляется уже после фазы загрузки плагинов — без скана
-- пути есть, а команды и маппинги мертвы
local plugged_dir = vim.fn.expand('~/.vim/plugged')
-- В общий скан не включаем:
-- nerdtree — отложенная загрузка из plugins.vim ('on':),
--   его тянет сам vim-plug по первой команде
-- supertab, papercolor-theme — только для vim (guard has('nvim') в plugins.vim),
--   в nvim supertab перехватывал бы <Tab> у nvim-cmp
local skip_scan = {
  nerdtree = true, -- 'on': 'NERDTreeToggle'
  supertab = true, -- только vim
  ['papercolor-theme'] = true, -- только vim
}
local plugged_plugins = {}
if vim.fn.isdirectory(plugged_dir) == 1 then
  for _, dir in ipairs(vim.fn.readdir(plugged_dir)) do
    local plugin_path = plugged_dir .. '/' .. dir
    if vim.fn.isdirectory(plugin_path) == 1 and not skip_scan[dir] then
      table.insert(plugged_plugins, {
        dir = plugin_path,
        name = dir,
        lazy = false, -- Загружаем сразу
      })
    end
  end
end

-- Настройка lazy.nvim
require('lazy').setup({
  -- Плагины Neovim: ~/.config/nvim/lua/plugins.lua
  { import = 'plugins' },

  -- Neovim LSP: ~/.config/nvim/lua/lsp.lua
  { import = 'lsp' },

  -- Emmet: ~/.config/nvim/lua/emmet.lua
  -- реализовано через LSP
  -- { import = 'emmet' },

  -- Vim-плагины из общего каталога (загрузка через lazy)
  plugged_plugins,

  -- vim-plug для установки плагинов Vim
  -- :PlugInstall
  {
    'junegunn/vim-plug',
    config = function()
      local plug_script = vim.fn.stdpath('data') .. '/lazy/vim-plug/plug.vim'
      if vim.fn.filereadable(plug_script) == 1 then
        vim.cmd('source ' .. plug_script)
        -- Общий каталог с vim (~/.vim/plugged): ставить/обновлять можно
        -- с любой стороны, чистить (:PlugClean) только из vim —
        -- в nvim papercolor/supertab не декларированы и попадут под удаление
        vim.fn['plug#begin'](vim.fn.expand('~/.vim/plugged'))
        vim.cmd('source ~/.config/vim/plugins.vim')
        vim.fn['plug#end']()
      else
        print('vim-plug script not found at ' .. plug_script .. '. Run :Lazy sync to install.')
      end
    end,
  },
})

