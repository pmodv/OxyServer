module OxyServer

using Oxygen
export Model, bootServer, simulate



# mutable because we will update the field value of an existing struct in this server
mutable struct Model
    x::Int32 
end

# Dummy simulation function 
function simulate(a::Int32)
    model = Model(a)
    println("Simulation Complete for model with parameter ",model.x)
end



function bootServer()
    @info "Booting Server"
    serve(host="0.0.0.0")
     
end

end # end module