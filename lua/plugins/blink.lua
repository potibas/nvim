return {
  'saghen/blink.cmp',

  lazy = false, -- lazy loading handled internally

  -- use a release tag to download pre-built binaries
  version = 'v0.7.4',

  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.completion.enabled_providers' },

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {

    keymap = {
      ['<C-/>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
      ['<C-c>'] = { 'hide', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'show', 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'show', 'select_next', 'fallback' },

      ['<C-l>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'accept', 'fallback' },
    },

    ---@type blink.cmp.AppearanceConfig
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,

      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',
    },

    ---@type blink.cmp.SourceConfig
    sources = {
      ---@type blink.cmp.SourceModeConfig
      completion = {
        enabled_providers = { 'lsp', 'path' },
      },

      providers = {

        --- @type blink.cmp.SourceProviderConfig
        lsp = {
          max_items = 100,

          -- Remove the "Text" items from lsp autocomplete
          transform_items = function(_, items)
            return vim.tbl_filter(function(item)
              return item.kind ~= vim.lsp.protocol.CompletionItemKind.Text
            end, items)
          end,
        },
      },
    },

    completion = {
      menu = {
        enabled = true,
        -- min_width = 15,
        -- max_height = 10,
        -- border = 'none',
        border = 'rounded',
        -- winblend = 0,
        -- winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        -- scrolloff = 2,
        -- scrollbar = true,
        scrollbar = false,
        -- direction_priority = { "s", "n" },
        -- order = { n = "bottom_up", s = "top_down" },
        -- auto_show = true,

        -- Controls how the completion items are rendered on the popup window
        draw = {
          -- align_to_component = "label", -- or 'none' to disable
          -- padding = 1,
          -- gap = 1,
          -- treesitter = false, -- Use treesitter to highlight the label text
          -- Components to render, grouped by column
          columns = {
            { 'source_name', 'kind', gap = 1 },
            { 'kind_icon', 'label', 'label_description', gap = 1 },
          },
        },
      },

      documentation = {
        -- auto_show = false,
        auto_show = true,
        -- auto_show_delay_ms = 500,
        -- update_delay_ms = 50,
        -- treesitter_highlighting = true,
        window = {
          -- min_width = 10,
          -- max_width = 60,
          -- max_height = 20,
          -- desired_min_width = 50,
          -- desired_min_height = 10,
          -- border = "padded",
          border = 'rounded',
          -- winblend = 0,
          -- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
          -- scrollbar = true,
          scrollbar = false,
          direction_priority = {
            -- menu_north = { "e", "w", "n", "s" },
            -- menu_south = { "e", "w", "s", "n" },
            menu_north = { 'e', 'w' },
            menu_south = { 'e', 'w' },
          },
        },
      },
    },

    signature = {
      -- enabled = false,
      enabled = true,

      --[[
      trigger = {
        enabled = true,
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        show_on_insert_on_trigger_character = true,
      },
      ]]

      window = {
        -- min_width = 1,
        -- max_width = 100,
        -- max_height = 10,
        -- border = "padded",
        border = 'rounded',
        -- winblend = 0,
        -- winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        -- scrollbar = false,
        -- direction_priority = { "n", "s" },
        -- treesitter_highlighting = true,
      },
    },
  },
}
