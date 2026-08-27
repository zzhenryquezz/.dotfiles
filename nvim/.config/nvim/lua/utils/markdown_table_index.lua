local function index_markdown_tables()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local in_table = false
  local header = false
  local index = 1

  for i, line in ipairs(lines) do
    local is_table = line:match("^%s*|")
    local is_separator = line:match("^%s*|%s*:?-+%s*|")

    if is_table then
      if not in_table then
        in_table = true
        header = true
      end

      if is_separator then
        -- separator row, ignore
      elseif header then
        -- header row, ignore
        header = false
      else
        lines[i] = line:gsub(
          "^(%s*|%s*)%d+(%s*|)",
          "%1" .. index .. "%2",
          1
        )

        index = index + 1
      end
    else
      in_table = false
      header = false
    end
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

vim.api.nvim_create_user_command(
  "MarkdownTableIndex",
  index_markdown_tables,
  {}
)
