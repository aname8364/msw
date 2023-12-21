function on_world_logic(instance)
   local entity = get_entity(instance)
   if not check_player(entity) and not check_world(entity) and not check_map(entity) then
      local pos = get_pos(instance)
      local my_pos = get_my_pos()
      set_pos(pos, my_pos)
   end
end