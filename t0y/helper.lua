LaunchMonoDataCollector()

function find_game_function(namespace_name, class_name, method_name)
    local class = mono_findClass(namespace_name, class_name)
    local class_methods = mono_class_enumMethods(class)
 
    local result = {}
 
    for i,method_data in pairs(class_methods) do
       if method_data.name == method_name then
          local index = #result+1
          result[index] = {}
          result[index].id = method_data.method
          result[index].sig = mono_method_getSignature(result[index].id)
          result[index].domain = namespace_name
       end
    end
 
    return result
 end
 
function select_method_by_sig(method_list, method_sig)
    for i=1, #method_list do
       if method_list[i].sig == method_sig then
          return method_list[i]
       end
    end
 end

function call_game_function(method, instance, args)
    return mono_invoke_method(method.domain, method.id, instance, args)
 end

