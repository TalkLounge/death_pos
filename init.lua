-- clientmods/death_pos/init.lua
-- =================
-- See README.txt for licensing and other information.

local localplayer
local mod_storage = minetest.get_mod_storage()
local ip = minetest.get_server_info().ip
local port = minetest.get_server_info().port
local death_pos1 = ip .."-".. port .."_pos1"
local death_pos2 = ip .."-".. port .."_pos2"
local death_pos3 = ip .."-".. port .."_pos3"
local death_pos4 = ip .."-".. port .."_pos4"
local death_pos5 = ip .."-".. port .."_pos5"

minetest.register_on_connect(function()
    localplayer = minetest.localplayer
end)

minetest.register_on_death(function()
    local pos = localplayer:get_pos()
    local position = minetest.pos_to_string(pos, 0)
    local bones_pos1 = mod_storage:get_string(death_pos1)
    local bones_pos2 = mod_storage:get_string(death_pos2)
    local bones_pos3 = mod_storage:get_string(death_pos3)
    local bones_pos4 = mod_storage:get_string(death_pos4)
    local bones_pos5 = mod_storage:get_string(death_pos5)
    minetest.after(1, function()
    mod_storage:set_string(death_pos1, position)
    end)
    mod_storage:set_string(death_pos2, bones_pos1)
    mod_storage:set_string(death_pos3, bones_pos2)
    mod_storage:set_string(death_pos4, bones_pos3)
    mod_storage:set_string(death_pos5, bones_pos4)
  end)

minetest.register_chatcommand("death_pos", {
    description = "Show your last 5 death positions",
    func = function()
      local bones_pos5 = mod_storage:get_string(death_pos5)
      local bones_pos4 = mod_storage:get_string(death_pos4)
      local bones_pos3 = mod_storage:get_string(death_pos3)
      local bones_pos2 = mod_storage:get_string(death_pos2)
      local bones_pos1 = mod_storage:get_string(death_pos1)
      if bones_pos5 ~= "" then
      minetest.display_chat_message("Fifth death position: ".. bones_pos5)
      end
      if bones_pos4 ~= "" then
      minetest.display_chat_message("Forth death position: ".. bones_pos4)
      end
      if bones_pos3 ~= "" then
        minetest.display_chat_message("Third last death position: ".. bones_pos3)
      end
      if bones_pos2 ~= "" then
        minetest.display_chat_message("Second last death position: ".. bones_pos2)
      end
      if bones_pos1 ~= "" then
        minetest.display_chat_message("Last death position: ".. bones_pos1)
      end
  end})

