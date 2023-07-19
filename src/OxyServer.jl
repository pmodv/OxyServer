module OxyServer

using Oxygen
export Model, simulate, setValue, getValue, getModel, bootServer
# mutable because we will update the field value of an existing struct in this server
mutable struct Model
    x::Int32 
end


function bootServer()
    serve(host="0.0.0.0")
end

end # end module