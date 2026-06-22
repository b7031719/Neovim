-- table to store REPL state (buffer id and channel id)
local repl = {
	term_buf = 0,
	chan_id = 0,
}

-- function to check if a repl is open
local function is_repl_open()
	if repl.term_buf == 0 or not vim.api.nvim_buf_is_valid(repl.term_buf) then
		return false
	end

	if vim.bo[repl.term_buf].buftype ~= "terminal" then
		return false
	end

	local chan = vim.b[repl.term_buf].terminal_job_id
	if not chan or chan == 0 then
		return false
	end

	return true
end

-- function to start a Python devshell repl with nix develop
local function start_python_devshell()
	-- reverts the active window back to the current window on completion
	local current_win = vim.api.nvim_get_current_win()

	-- check if repl is already open
	if is_repl_open() then
		vim.notify("repl already open")
		return
	end

	-- if repl is not already open then start a new repl
	vim.cmd("botright 12new") -- creates a new window at the bottom right with height of 12 rows
	local job_id = vim.fn.jobstart({ vim.o.shell, "-c", "nix develop --command python3" }, {
		term = true,
		on_exit = function()
			-- clean up state when terminal closes
			repl.term_buf = 0
			repl.chan_id = 0
		end,
	})

	-- store repl state
	repl.term_buf = vim.api.nvim_get_current_buf()
	repl.chan_id = job_id

	vim.api.nvim_set_current_win(current_win)
end

-- stop devshell process, delete buffer and update state when window containing devshell buffer closes
vim.api.nvim_create_autocmd("WinClosed", {
	callback = function(args)
		if args.buf == repl.term_buf then
			vim.fn.jobstop(repl.chan_id)
			pcall(vim.api.nvim_buf_delete, repl.term_buf, { force = true })
			repl.term_buf = 0
			repl.chan_id = 0
		end
	end,
})

-- function to send a command to the repl
local function send_to_repl(cmd)
	-- check if repl is open first
	if not is_repl_open() then
		vim.notify("No active repl found")
		return
	end

	vim.fn.chansend(repl.chan_id, cmd .. "\n")
end

-- function to send the highlighted block of code under the cursor to the repl
local function run_code_block()
	local filetype = vim.bo.filetype

	if filetype == "python" then
		-- Yank the selected text and store in register v
		vim.cmd('normal! "vy')
		local text = vim.fn.getreg("v")
    text = vim.trim(text) .. "\n"

		if text == "" then
			vim.notify("No text selected")
			return
		end

		send_to_repl(text)

		-- Move cursor to (hopefully) land on the next paragraph
		local keys = vim.api.nvim_replace_termcodes("}j", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", false)
	else
		vim.notify("Current buffer is not a python file")
	end
end

-- function to run the entire python file in the repl
local function run_file()
	local filetype = vim.bo.filetype

	if filetype == "python" then
		local filename = vim.fn.expand("%:t")
		local cmd = string.format('exec(open("%s").read())\n', filename)

		send_to_repl(cmd)
	else
		vim.notify("Current buffer is not a python file")
	end
end

-- return a table containing the devshell and repl functions
local M = {}

M.setup = start_python_devshell

M.run_block = run_code_block
M.run_file = run_file

return M
