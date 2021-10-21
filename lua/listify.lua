local function wrap_in_quotes(content)
  return "'" .. content .. "'"
end

local function append_comma(content)
  return content .. ","
end

local function replace_text(bufnr, linenr, content)
  vim.api.nvim_buf_set_lines(bufnr, linenr - 1, linenr, true, {content})
end

local function listify_line(bufnr, linenr, isLastLine)
  local original = vim.api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, true)[1]
  local modified = wrap_in_quotes(original)

  if not isLastLine then
    modified = append_comma(modified)
  end

  replace_text(bufnr, linenr, modified)
end

local function collapse()
  vim.cmd('1,$join')
end

local function listify(shouldCollapse, bufnr)
  local bufnr = bufnr or 0
  local lineCount = vim.api.nvim_buf_line_count(bufnr)

  for i=1,lineCount do
    listify_line(bufnr, i, i == lineCount)
  end

  if shouldCollapse then
    collapse()
  end
end

return {
  listify = listify
}
