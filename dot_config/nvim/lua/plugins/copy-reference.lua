return {
	"ranelpadon/python-copy-reference.vim",
	cmd = { "PythonCopyReferencePytest", "PythonCopyReferenceImport" },
	ft = "python",
	keys = {
		{ "<leader>r", "", desc = "+references" },
		{ "<leader>rp", "<cmd>PythonCopyReferencePytest<cr>", desc = "Copy reference as pytest formart" },
		{ "<leader>ri", "<cmd>PythonCopyReferenceImport<cr>", desc = "Copy reference as importformart" },
	},
}
