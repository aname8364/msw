local function modify_buffer()
    local buffer_data = readString (RDX+0x20, R8)
    local name_size   = readInteger(R9+0x10)
    local script_name = readString (R9+0x14, name_size*2, true)
 
    --(i) now my dumper cant handle multiple files with same filename like chunk
    --(i) so added filter since user cant modify them
    if script_name == "chunk" then
       return
    end
 
    local my_script_path = ("%sGameScript\\%s.lua"):format(TrainerOrigin, script_name)
 
    local file = io.open(my_script_path, "rb")
    if file then
       local new_data   = file:read("a")
       local new_length = #new_data
       file:close()
 
       local new_buffer = allocateMemory(0x20 + new_length)
       writeQword(new_buffer       , readQword(RDX))
       writeQword(new_buffer+0x8   , readQword(RDX+0x8))
       writeQword(new_buffer+0x10  , readQword(RDX+0x10))
       writeQword(new_buffer+0x18  , new_length)
       writeString(new_buffer+0x20 , new_data)
 
       RDX = new_buffer
       R8  = new_length
 
       printf("Loaded Script: %s", my_script_path)
    end
 end
 
 openProcess("msw.exe")
 debug_setBreakpoint(getAddress("GameAssembly.dll+2E5B9E0"), modify_buffer)
 