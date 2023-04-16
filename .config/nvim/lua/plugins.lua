return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    use 'EdenEast/nightfox.nvim' -- Colorscheme
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            require('setup.lspconfig')
        end,
    } 
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        config = function()
            require('setup.nvim-cmp')
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'HiPhish/nvim-ts-rainbow2',
        },
        run = function()
            local treesitter = require('nvim-treesitter.install')
            treesitter.update({ with_sync = true })()
        end,
        config = function()
            require('setup.nvim-treesitter')
        end,
    }
    use {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('setup.nvim-tree')
        end,
    }
    use {
        'folke/which-key.nvim',
        config = function()
            require('setup.which-key')
        end,
    }
    use 'lukas-reineke/indent-blankline.nvim'
end)
