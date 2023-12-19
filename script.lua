local function read_string(address, is_wide_char)
    local length = readInteger(address+0x10)
    local data
    if is_wide_char then
       data = readString(address+0x14, length*2, true)
    else
       data = readString(address+0x14, length)
    end
    return data
 end

 local function do_action()
    local action_name = RDX
    printf("DoAction: %s", read_string(action_name, true))
 end

 openProcess("msw.exe")
 debug_setBreakpoint(0x7FFA733E8520, do_action)