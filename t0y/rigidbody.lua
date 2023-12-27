rigidbody_component = {
    namespace = "MOD.Core";
    component = "RigidbodyComponent";
 }
 
rigidbody_component.new = function(self, address)
    local obj = {address=address}
    return setmetatable(obj, {__index=self})
 end
 
rigidbody_component.down_jump = function(self)
    local down_jump = find_game_function(self.namespace, self.component, "DownJump")[1]
    local args = {}
    return call_game_function(down_jump, self.address, args)
 end
 
rigidbody_component.just_jump = function(self, jump_rate)
    local just_jump = find_game_function(self.namespace, self.component, "JustJump")[1]
    local args = {
       {type=vtQword, value=0x3F8000003F800000} --> lazy to define vec types..
    }
    return call_game_function(just_jump, self.address, args)
end

--------------- not ingame method ------------------
local offset_air_pos  = 0x128
local offset_walk_pos = 0x120

rigidbody_component.current_pos = function(self)
   local vec2_pos = {}   
   vec2_pos.x = readFloat(self.address + offset_air_pos)
   vec2_pos.y = readFloat(self.address + offset_air_pos+4)
   return vec2_pos
end

local offset_ignore_move_boundary = 0x1BD

rigidbody_component.ignore_move_boundary = function(self, boolean)
    writeByte(self.address + offset_ignore_move_boundary, boolean and 0x1 or 0x0)
end