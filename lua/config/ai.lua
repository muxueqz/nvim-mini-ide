local popup = require("plenary.popup")
local Job = require("plenary.job")
local curl = require("plenary.curl")

-- local bot_name = 'gpt-3.5-turbo'
-- local bot_name = 'bing'
local bot_name = "chatgpt"

function _display(lines, name, switch_tab)
  vim.schedule(function()
    local update_tab = function(buf, lines)
      -- 在AI标签页中插入文本
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      -- 切换到AI标签页
      if switch_tab then
        vim.api.nvim_set_current_buf(buf)
        -- 设置光标位置为最后一行的末尾
        local last_line = vim.api.nvim_buf_line_count(buf)
        local last_col = 0
        vim.api.nvim_win_set_cursor(0, { last_line, last_col })
      end
    end
    -- 搜索名为AI的标签页，如果存在就直接切换到该标签页
    -- local existing_tabpage = vim.fn.tabpagenr('$')
    -- for i = 1, existing_tabpage do
    --   local tabpage_name = vim.fn.bufname(vim.fn.tabpagebuflist(i)[1])
    --   if tabpage_name == 'AI' then
    --     vim.fn.tabpagenr(i)
    --     return
    --   end
    -- end
    local existing_bufnr = vim.fn.bufnr(name)
    if existing_bufnr ~= -1 then
      update_tab(existing_bufnr, lines)
      return
    end
    -- 打开新标签页
    vim.api.nvim_command("tabnew")

    -- 设置标签页名称
    vim.api.nvim_buf_set_name(0, name)

    -- 获取当前buffer
    local buf = vim.api.nvim_get_current_buf()
    update_tab(buf, lines)
    -- 配置退出时不需要保存
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "swapfile", false)
    -- 配置自动换行
    vim.api.nvim_set_option_value("wrap", true, { scope = "local" })

    vim.api.nvim_set_option_value("filetype", "markdown", { scope = "local" })
  end)
end

function display(lines)
  return _display(lines, "AI", true)
end

local ai_token = "my-token"
local ai_api = "http://localhost:8080"
-- 创建一个函数来执行curl POST请求并显示结果
function ai_ask(start_line, end_line)
  local post_data = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")

  local prompt = vim.fn.input("Prompt: ")
  if not prompt then
    return
  end

  local url = ai_api .. "/ask"
  local res = curl.post(url, {
    body = prompt .. "\n" .. post_data,
    headers = {
      ["Authorization"] = ai_token,
      ["model"] = bot_name,
    },
    timeout = 6000000,
    callback = function(output)
      -- print(vim.inspect.inspect(output))
      -- local lines = { vim.json.encode(output) }
      local lines = vim.split(output.body, "\n")
      vim.schedule(function()
        display(lines)
      end)
    end,
  })
end

function ai_history(start_line, end_line)
  local url = ai_api .. "/history"
  local res = curl.post(url, {
    headers = {
      ["Authorization"] = ai_token,
      ["model"] = bot_name,
    },
    timeout = 6000000,
    callback = function(output)
      -- print(vim.inspect.inspect(output))
      vim.schedule(function()
        -- -- print(vim.inspect.inspect(res))
        --
        local results = vim.json.decode(output.body)
        --     local res_body = [[
        -- [
        --   {
        --     "node": {
        --       "id": "TWVzc2FnZTo0NDk4NzQ3NjU=",
        --       "messageId": 449874765,
        --       "creationTime": 1682242501716928,
        --       "text": "在 Neovim 中，你可以使用 Lua 的 `json` 库来解析 JSON 数据。该库可以通过 `luarocks` 工具进行安装，安装命令如下：\n\n```\nluarocks install lua-cjson\n```\n\n安装完成后，你可以在 Lua 脚本中使用 `cjson` 模块来解析 JSON 数据。以下是一个简单的示例：\n\n```lua\n-- 导入 cjson 模块\nlocal cjson = require('cjson')\n\n-- 解析 JSON 数据\nlocal json_data = '{\"name\": \"Alice\", \"age\": 30}'\nlocal data = cjson.decode(json_data)\n\n-- 打印解析结果\nprint(data.name) -- 输出 Alice\nprint(data.age) -- 输出 30\n```\n\n在这个示例中，`cjson.decode()` 函数用于将 JSON 数据解析为 Lua 表。解析后的数据可以像普通 Lua 表一样进行操作。注意，`cjson` 模块使用了 C 语言实现的高效 JSON 解析器，因此在处理大量 JSON 数据时，比纯 Lua 实现的 JSON 解析器更快。",
        --       "author": "chinchilla",
        --       "linkifiedText": "在 Neovim 中，你可以使用 Lua 的 `json` 库来解析 JSON 数据。该库可以通过 `luarocks` 工具进行安装，安装命令如下：\n\n```\nluarocks install lua-cjson\n```\n\n安装完成后，你可以在 Lua 脚本中使用 `cjson` 模块来解析 JSON 数据。以下是一个简单的示例：\n\n```lua\n-- 导入 cjson 模块\nlocal cjson = require('cjson')\n\n-- 解析 JSON 数据\nlocal json_data = '{\"name\": \"Alice\", \"age\": 30}'\nlocal data = cjson.decode(json_data)\n\n-- 打印解析结果\nprint(data.name) -- 输出 Alice\nprint(data.age) -- 输出 30\n```\n\n在这个示例中，`cjson.decode()` 函数用于将 JSON 数据解析为 Lua 表。解析后的数据可以像普通 Lua 表一样进行操作。注意，`cjson` 模块使用了 C 语言实现的高效 JSON 解析器，因此在处理大量 JSON 数据时，比纯 Lua 实现的 JSON 解析器更快。",
        --       "state": "complete",
        --       "contentType": "text_markdown",
        --       "suggestedReplies": [
        --         "Can you show me an example of using cjson to encode a Lua table as JSON?",
        --         "Is there a way to handle errors when decoding JSON data with cjson?",
        --         "What other Lua libraries can I use in Neovim for parsing JSON data?"
        --       ],
        --       "vote": null,
        --       "voteReason": null,
        --       "chat": {
        --         "chatId": 4644896,
        --         "defaultBotNickname": "chinchilla",
        --         "id": "Q2hhdDo0NjQ0ODk2"
        --       },
        --       "__isNode": "Message",
        --       "__typename": "Message"
        --     },
        --     "cursor": "449874765",
        --     "id": "TWVzc2FnZUVkZ2U6NDQ5ODc0NzY1OjQ0OTg3NDc2NQ=="
        --   }
        --   ]
        --   ]]
        --     local results = vim.json.decode(res_body)

        local lines = {}
        for _, line in pairs(results) do
          local seconds = line.node.creationTime / 1000000 -- 将微秒数转换为秒数
          local datetime = os.date("%Y-%m-%d %H:%M:%S", seconds)
          table.insert(lines, line.node.author .. " at " .. datetime .. " :")
          local _lines = vim.split(line.node.text, "\n")
          for _, value in pairs(_lines) do
            table.insert(lines, value)
          end
          table.insert(lines, string.rep("-", 80))
          table.insert(lines, "")
        end
        display(lines)
      end)
    end,
  })
end

function ai_change_bot()
  local name = vim.fn.input("Bot: ")
  bot_name = name
end

function ai_reload()
  local url = ai_api .. "/reload"
  local res = curl.post(url, {
    headers = {
      ["Authorization"] = ai_token,
      ["model"] = bot_name,
    },
    timeout = 6000000,
    callback = function(output)
      -- print(vim.inspect.inspect(output))
      -- local lines = { vim.json.encode(output) }
      local lines = vim.split(output.body, "\n")
      vim.schedule(function()
        display(lines)
      end)
    end,
  })
end

function ai_list_chat()
  local url = ai_api .. "/list_chat"
  local res = curl.get(url, {
    headers = {
      ["Authorization"] = ai_token,
      ["model"] = bot_name,
    },
    timeout = 6000,
  })
  return vim.json.decode(res.body)
end

function ai_talk_to(chat_id)
  local url = ai_api .. "/talk_to/" .. chat_id
  local res = curl.get(url, {
    headers = {
      ["Authorization"] = ai_token,
      ["model"] = bot_name,
    },
    timeout = 6000,
  })
  print(vim.inspect.inspect(res))
  -- return vim.json.decode(res.body)
end

--

function unescape_html(text)
  local escapes = {
    ["&gt;"] = ">",
    ["&lt;"] = "<",
    ["&quot;"] = '"',
    ["&apos;"] = "'",
    ["&ensp;"] = " ",
    ["&emsp;"] = " ",
    ["&amp;"] = "&",
  }
  return (string.gsub(text, "&[^ ;]+;", escapes))
end

-- 定义一个命令，将当前选中文本作为POST数据并显示结果
vim.cmd([[command! -range=% AskAI lua ai_ask(<line1>,<line2>)]])
vim.cmd([[command! HistoryAI lua ai_history()]])
vim.cmd([[command! ChangeAI lua ai_change_bot()]])

function ai_ask_bybito(start_line, end_line)
  local post_data = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")
  local prompt = vim.fn.input("Prompt: ")
  local body = prompt .. "\n" .. post_data
  vim.call("BitoAiExec", "generate", body)
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local state = require("telescope.actions.state")

function ai_pick_chat(opts)
  opts = opts or {}
  -- local chat_list = ai_list_chat()
  local chat_list = {}
  for key, value in pairs(ai_list_chat()) do
    table.insert(chat_list, { key, value })
  end
  table.sort(chat_list, function(entry1, entry2)
    return tonumber(entry1[2]) < tonumber(entry2[2])
  end)
  pickers
    .new(opts, {
      previewer = false,
      prompt_title = "Chats",
      finder = finders.new_table({
        results = chat_list,
        entry_maker = function(entry)
          -- print(vim.inspect.inspect(entry))
          return {
            value = entry[2],
            display = entry[2] .. ":" .. entry[1],
            ordinal = entry[2] .. ":" .. entry[1],
          }
        end,
      }),
      -- sorter = conf.generic_sorter(opts),
      -- sorter = conf.generic_sorter(sort_opts),
      -- sorter = sorters.get_fzy_sorter(sort_opts),
      -- sorter = sorters.fuzzy_with_index_bias(sort_opts),
      -- sorter = sorters.get_generic_fuzzy_sorter(sort_opts),
      sorter = sorters.get_generic_fuzzy_sorter(),
      -- sorter = sorters.prefilter(sort_opts),
      -- sorter = sorters.get_substr_matcher(sort_opts),
      -- sorter = sorters.get_substr_matcher(),

      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)

          local selection = state.get_selected_entry()
          -- print(vim.inspect.inspect(selection))
          -- local chat_id = chat_list[selection[1]]
          local chat_id = selection.value

          -- print(vim.inspect.inspect(chat_id))
          ai_talk_to(chat_id)
        end)
        return true
      end,
    })
    :find()
end
