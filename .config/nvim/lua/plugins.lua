return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    use 'EdenEast/nightfox.nvim' -- Colorscheme
    use 'nvim-tree/nvim-web-devicons'
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'p00f/clangd_extensions.nvim',
        },
        config = function()
            require('setup.lspconfig')
        end,
    } 
    use {
        'mfussenegger/nvim-lint',
        config = function()
            require('setup.lint')
        end,
    }
    use {
        'mhartington/formatter.nvim',
        config = function()
            require('setup.formatter')
        end,
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'p00f/clangd_extensions.nvim',
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
    use {
        'folke/trouble.nvim',
        config = function()
            require('setup.trouble')
        end,
    }
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('setup.telescope')
        end,
    }
    use {
        'startup-nvim/startup.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('setup.startup')
        end,
    }
    use {
        'nvim-telescope/telescope-file-browser.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('setup.telescope-file-browser')
        end,
    }
end)
