-- ~/.config/nvim/lua/plugins/swift.lua
-- Swift-specific nice-to-haves: xcodebuild.nvim for building/debugging
-- iOS/macOS apps from within Neovim.

return {
  {
    "wojciech-kulik/xcodebuild.nvim",
    ft = { "swift" },
    cmd = { "XcodebuildPicker", "XcodebuildBuild", "XcodebuildTest", "XcodebuildSetup" },
    dependencies = {
      "nvim-telescope/telescope.nvim",  -- xcodebuild's pickers are Telescope-based
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      show_build_progress_bar = true,
      logs = { auto_close_on_success = true },
      code_coverage = { enabled = false },
    },
    keys = {
      { "<leader>X",  "",                            desc = "+xcode", ft = "swift" },
      { "<leader>Xl", "<cmd>XcodebuildToggleLogs<cr>",   desc = "Toggle logs",          ft = "swift" },
      { "<leader>Xb", "<cmd>XcodebuildBuild<cr>",        desc = "Build project",        ft = "swift" },
      { "<leader>XB", "<cmd>XcodebuildBuildForTesting<cr>", desc = "Build for testing", ft = "swift" },
      { "<leader>Xr", "<cmd>XcodebuildBuildRun<cr>",     desc = "Build & Run",          ft = "swift" },
      { "<leader>Xt", "<cmd>XcodebuildTest<cr>",         desc = "Run tests",            ft = "swift" },
      { "<leader>XT", "<cmd>XcodebuildTestClass<cr>",    desc = "Run current test class", ft = "swift" },
      { "<leader>Xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", desc = "Toggle coverage", ft = "swift" },
      { "<leader>Xs", "<cmd>XcodebuildSelectScheme<cr>", desc = "Select scheme",        ft = "swift" },
      { "<leader>Xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select device",        ft = "swift" },
      { "<leader>Xp", "<cmd>XcodebuildPicker<cr>",       desc = "Show all actions",     ft = "swift" },
      { "<leader>Xq", "<cmd>Telescope quickfix<cr>",     desc = "Show Quickfix",        ft = "swift" },
    },
  },
}
