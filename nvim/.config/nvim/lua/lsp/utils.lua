return {
    get_global_node_modules_path = function()
        local handle = io.popen("npm root -g")

        local global_node_modules = handle:read("*a"):gsub("%s+", "")

        handle:close()

        return global_node_modules
    end
}
