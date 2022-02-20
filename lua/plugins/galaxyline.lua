return function ()
  local get_color = require("utils").get_color

  local bo = vim.bo
  local gl = require("galaxyline")
  local lsp = require("galaxyline.provider_lsp")
  local buffer = require("galaxyline.provider_buffer")
  local condition = require("galaxyline.condition")

  local gls = gl.section

  gl.short_line_list = {
    "NvimTree",
    "packer",
    "Outline",
    "toggleterm",
  }

  -- {{{ Utility functions
  local function is_dashboard()
    local buftype = buffer.get_buffer_filetype()
    if buftype == "DASHBOARD" then
      return true
    end
  end

  local function is_not_dashboard()
    local buftype = buffer.get_buffer_filetype()
    if buftype ~= "DASHBOARD" then
      return true
    end
  end
  -- }}}

  -- Left side
  gls.left[1] = {
    RainbowLeft = {
      provider = function()
        return "▊ "
      end,
      highlight = { get_color("blue"), get_color("bg") },
    },
  }
  gls.left[2] = {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
        -- TODO: find a less dirty way to set ViMode colors
        local mode_colors = {
          n = get_color("red")(),
          i = get_color("green")(),
          v = get_color("blue")(),
          [""] = get_color("blue")(),
          V = get_color("blue")(),
          c = get_color("magenta")(),
          no = get_color("red")(),
          s = get_color("orange")(),
          S = get_color("orange")(),
          ic = get_color("yellow")(),
          R = get_color("magenta")(),
          Rv = get_color("magenta")(),
          cv = get_color("red")(),
          ce = get_color("red")(),
          r = get_color("cyan")(),
          rm = get_color("cyan")(),
          ["r?"] = get_color("cyan")(),
          ["!"] = get_color("red")(),
          t = get_color("red")(),
        }
        mode_color = mode_colors[vim.fn.mode():byte()]
        if mode_color == nil then
          mode_color = get_color("yellow")()
	      end

        vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color)

        return " "
      end,
      highlight = { get_color("red"), get_color("bg"), "bold" },
    },
  }

  gls.left[3] = {
    GitIcon = {
      provider = function()
        return ""
      end,
      condition = condition.check_git_workspace,
      highlight = { get_color("red"), get_color("bg") },
      separator = " ",
      separator_highlight = { get_color("bg"), get_color("bg") },
    },
  }
  gls.left[4] = {
    GitBranch = {
      provider = "GitBranch",
      condition = condition.check_git_workspace,
      highlight = { get_color("green"), get_color("bg"), "bold" },
    },
  }
  gls.left[5] = {
    DiffSeparator = {
      provider = function()
        return "  "
      end,
      condition = is_not_dashboard,
      highlight = { get_color("bg"), get_color("bg") },
    },
  }
  gls.left[6] = {
    DiffAdd = {
      provider = "DiffAdd",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = "+", --
      highlight = { get_color("green"), get_color("bg") },
    },
  }
  gls.left[7] = {
    DiffModified = {
      provider = "DiffModified",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = "~", -- 
      highlight = { get_color("blue"), get_color("bg") },
    },
  }
  gls.left[8] = {
    DiffRemove = {
      provider = "DiffRemove",
      condition = condition.hide_in_width and is_not_dashboard,
      icon = "-", -- 
      highlight = { get_color("red"), get_color("bg") },
    },
  }

  -- gls.left[9] = {
  --   FileIcon = {
  --     provider = "FileIcon",
  --     condition = condition.buffer_not_empty and is_not_dashboard,
  --     highlight = {
  --       require("galaxyline.provider_fileinfo").get_file_icon_color,
  --       get_color("bg"),
  --     },
  --   },
  -- }
  gls.left[9] = {
    FileName = {
      provider = "FileName",
      condition = condition.buffer_not_empty and is_not_dashboard,
      highlight = { get_color("fg"), get_color("bg"), "bold" },
      separator = " ",
      separator_highlight = { get_color("bg"), get_color("bg") },
    },
  }

  -- Right side
  -- alternate separator colors if the current buffer is a dashboard
  gls.right[1] = {
    FileFormat = {
      provider = "FileFormat",
      condition = condition.hide_in_width and is_not_dashboard,
      highlight = { get_color("fg"), get_color("bg") },
      separator = " ",
      separator_highlight = { get_color("bg"), get_color("bg") },
    },
  }
  gls.right[2] = {
    FileEncode = {
      provider = "FileEncode",
      condition = condition.hide_in_width and is_not_dashboard,
      highlight = { get_color("fg"), get_color("bg") },
      separator = " ",
      separator_highlight = { get_color("bg"), get_color("bg") },
    },
  }
  gls.right[3] = {
    FileSize = {
      provider = "FileSize",
      condition = condition.buffer_not_empty and is_not_dashboard,
      highlight = {
        get_color("fg"),
        get_color("bg"),
      },
      separator = " ",
      separator_highlight = { get_color("bg"), get_color("bg") },
    },
  }
  gls.right[4] = {
    LinePercent = {
      provider = "LinePercent",
      condition = is_not_dashboard,
      highlight = { get_color("fg_alt"), get_color("bg") },
      separator = " ",
      separator_highlight = { get_color("bg"), get_color("bg") },
    },
  }

  gls.right[5] = {
    RainbowRight = {
      provider = function()
        return " ▊"
      end,
      highlight = { get_color("blue"), get_color("bg") },
    },
  }

  -- Short status line
  gls.short_line_left[1] = {
    ShortRainbowLeft = {
      provider = function()
        return "▊ "
      end,
      highlight = { get_color("blue"), get_color("bg") },
    },
  }
  gls.short_line_left[2] = {
    BufferType = {
      provider = "FileTypeName",
      condition = is_not_dashboard,
      highlight = { get_color("fg"), get_color("bg") },
    },
  }

  gls.short_line_right[1] = {
    BufferIcon = {
      provider = "BufferIcon",
      condition = is_not_dashboard,
      highlight = { get_color("yellow"), get_color("bg") },
    },
  }
  gls.short_line_right[2] = {
    ShortRainbowRight = {
      provider = function()
        return " ▊"
      end,
      highlight = { get_color("blue"), get_color("bg") },
    },
  }
  end
