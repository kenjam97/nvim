local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float {border = "rounded" }
    end,
  },
}

return packer.startup(function(use)   
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")

  -- General plugins
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use("windwp/nvim-autopairs")
  use("kyazdani42/nvim-tree.lua", {
    requires = {
      "kyazdani42/nvim-web-devicons"
    }
  })
  use("akinsho/bufferline.nvim", {
    requires = {
      "kyazdani42/nvim-web-devicons"
    }
  })
  use("moll/vim-bbye")

  -- cmp/lsp
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("onsails/lspkind-nvim")
  use("simrat39/symbols-outline.nvim")
  use("numToStr/Comment.nvim")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("lewis6991/gitsigns.nvim")
  use("sbdchd/neoformat")

  use("saadparwaiz1/cmp_luasnip")
  use("L3MON4D3/LuaSnip") 
  use("mbbill/undotree")

  -- Colorscheme section
  use("gruvbox-community/gruvbox")
  use("folke/tokyonight.nvim")

  use("nvim-treesitter/nvim-treesitter", {
    run = ":TSUpdate"
  })

  use("nvim-treesitter/playground")
  use("romgrk/nvim-treesitter-context")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
