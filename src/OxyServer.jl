module OxyServer

# every symbol must be listed below for export(i.e. used elsewhere)
export Model, simulate, setValue, getValue, getModel

# mutable because we will update the field value of an existing struct in this server
mutable struct Model
    x::Int32 
end

# Dummy simulation function
function simulate(a::Int32)
    model = Model(a)
    println("Simulation Complete for model with parameter ",model.x)
end

function setValue(m::Model,a::Int32)
    # mutate existing model
    m.x = a
    return m.x
end

function getValue() 
    return model.x
end

function getModel()
    return model
end

function bootServer()
    # initialize default model instance with value 3000
    model = Model(3000)
    serve(host="0.0.0.0")
end

end # end module