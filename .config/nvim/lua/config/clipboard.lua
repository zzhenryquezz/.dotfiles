-- Simple `clip.exe` configuration in init.lua
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "/mnt/c/Windows/System32/clip.exe",
            ["*"] = "/mnt/c/Windows/System32/clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", "")))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", "")))',
        },
        cache_enabled = 0,
    }
end
