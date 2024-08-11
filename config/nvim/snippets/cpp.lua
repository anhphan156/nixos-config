local get_buf_name = function()
	local buf_handle = vim.api.nvim_get_current_buf()
	local full_path  = vim.api.nvim_buf_get_name(buf_handle)
	local file_name  = vim.fn.fnamemodify(full_path, ":t")
	file_name        = string.upper(file_name);
	file_name        = string.gsub(file_name, '%.', '_')
	file_name        = string.gsub(file_name, '_.*$', '_H')
	return file_name
end

return {
	s("mkHeader", {
		t("#ifndef "), f(get_buf_name),
		t({ "", "#define " }), f(get_buf_name), t({ "", "" }),
		i(1),
		t({ "", "#endif" })
	}),
	s("vkst", { t("VK_STRUCTURE_TYPE_"), i(1) })
}
