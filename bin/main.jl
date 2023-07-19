using Oxygen,HTTP
#using OxyServer 

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



# initialize default model instance with value 3000
# Model struct defined in OxyServer.jl
model = Model(3000)


# "Interpolate" variable x in the endpoint
@get "/set/{x}" function(req,x::Int32) 

    priorValue = getValue()
    # constructor on Server initialization 
    newValue = setValue(model,x)

    println("New model created with field value ", newValue)
    return Dict("New model value is " => newValue, "Prior model value was " => priorValue)
end

@get "/get" function()

    currentModel = getModel()
    return Dict("Model is "=> currentModel, "Model type is: "=>typeof(model))
end

# return model IF it has the given field value of x 
@post "/check" function(req::HTTP.Request) 
    
    # json here is a function from Oxygen package 
    searchValue = json(req).value
        
    
    if isequal(searchValue, getValue())
        println("Model is available for value ", searchValue)
        return Dict( "Available model is: "=> model, "Model type is: "=>typeof(model))
    else
        println("Model with value ",searchValue," does not exist.")
        return Dict("Error" => "Queried model does not exist")
    end

end

# Default handler for GET
@get "*" function () 
    return HTTP.Response(404,"This endpoint does not exist")
end

# Default handler for POST
@post "*" function () 
    return HTTP.Response(404,"This endpoint does not exist")
end


# Run a simulation with model value x
@get "/simulate/{x}" function(req,x::Int32) 
    simulate(x) #PlanViewAnalysis.simulate(model)
    return Dict("Simulation State: " => "Simulation executed")
end

# Shut-down server
@get "/kill" function ()
    terminate()
    return HTTP.Response(200,  "Server is Shutdown")
end

# defined in OxyServer.jl - NOTE DEFAULT PORT IS 8080
# MAKE SURE TO SET PORT TO 8080 IN JULIAHUB WHEN LAUNCHING APPLICATION
bootServer()
