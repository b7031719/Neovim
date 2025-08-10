return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio"
	},
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, mode = "n", { desc = "Dap toggle breakpoint" } },
    { "<leader>dc", function() require("dap").continue() end, mode = "n", { desc = "Dap continue" } },
    { "<leader>dso", function() require("dap").step_over() end, mode = "n", { desc = "Dap step over" } },
    { "<leader>dsi", function() require("dap").step_into() end, mode = "n", { desc = "Dap step into" } },
    { "<leader>dsx", function() require("dap").step_out() end, mode = "n", { desc = "Dap step out" } },
  },
	config = function()
		local dap, dapui = require("dap"), require("dapui")
    
    -- Setup dapui
    dapui.setup({})
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

	end,
}
