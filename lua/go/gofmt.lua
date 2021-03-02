local M = {}

local vim = vim
local Job = require('plenary.job')

function M.run(opt)
    local filePath = vim.api.nvim_buf_get_name(0)
    local cwd = vim.fn.expand('%:p:h')
    Job:new({
        command = 'gofmt',
        args = { '-w', filePath },
        cwd = cwd,
        on_exit = function(j, return_val)
            if return_val == 0 then
                print('[GoFmt] Success')
            else
                print(string.Format('[GoFmt] Error %d: %s', return_val, Job:result()))
            end
        end,
    }):sync()
    vim.api.nvim_exec('edit!', true)
end

return M