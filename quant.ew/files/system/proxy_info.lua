local module = {}

function module.on_world_update()
    if GameGetFrameNum() % 4 ~= 2 then
        return
    end
    local x, y = GameGetCameraPos()
    local mx, my = EntityGetTransform(ctx.my_player.entity)
    if mx == nil then
        return
    end
    local is_dead = 0
    if GameHasFlagRun("ew_flag_notplayer_active") then
        is_dead = 1
    end
    local d = 0
    if ctx.proxy_opt.no_notplayer or ctx.proxy_opt.perma_death then
        d = 1
    end
    net.proxy_send(
        "cam_pos",
        math.floor(x)
            .. " "
            .. math.floor(y)
            .. " "
            .. math.floor(mx)
            .. " "
            .. math.floor(my)
            .. " "
            .. is_dead
            .. " "
            .. d
            .. " 0 0 0 0"
    )
end

return module
