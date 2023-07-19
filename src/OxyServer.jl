module OxyServer

using Oxygen
export Model, bootServer
# mutable because we will update the field value of an existing struct in this server
mutable struct Model
    x::Int32 
end


function bootServer()
    serve(host="0.0.0.0")
end

end # end module