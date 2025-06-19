local M = {}

--- Get an empty table of mappings with a key for each map mode.
--- @return table<string,table> # a table with entries for each map mode.
function M.get_mappings_template()
	local maps = {}
	for _, mode in ipairs({
		"",
		"n",
		"v",
		"x",
		"s",
		"o",
		"!",
		"i",
		"l",
		"c",
		"t",
		"ia",
		"ca",
		"!a",
	}) do
		maps[mode] = {}
	end
	return maps
end

--- Set a table of mappings.
function M.set_mappings(map_table, base)
	-- iterate over the first keys for each mode
	for mode, maps in pairs(map_table) do
		-- iterate over each keybinding set in the current mode
		for keymap, options in pairs(maps) do
			-- build the options for the command accordingly
			if options then
				local cmd
				local keymap_opts = base or {}
				if type(options) == "string" or type(options) == "function" then
					cmd = options
				else
					cmd = options[1]
					keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
					keymap_opts[1] = nil
				end
					vim.keymap.set(mode, keymap, cmd, keymap_opts)
			end
		end
	end
end


return M
