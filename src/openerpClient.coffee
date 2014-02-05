###

###

# External dependencies
Q = require 'q'

# Internal dependencies
Connector = require "./connector"

models = {}
["Product", "Partner", "SaleOrder", "Employee", "User", "State", "Sales", "GlobalSales", "Company"].map (modelName) ->
    name = modelName[0].toLowerCase() + modelName[1..-1]    
    models[modelName] = require "./models/" + name

class OpenerpClient

    constructor: ({dbname, hostname, port}) ->
        @connector = new Connector dbname, hostname, port        
        
        for model of models            
            @[model] = new models[model](@connector)

    login: (username, password) =>

        promise = Q.defer()

        params =  [
            @connector.dbname,
            username,
            password
        ]       

        @connector.commonCall('login', params).then (userId) =>

            @connector.setUser userId, password
            promise.resolve userId

        .fail (err) =>
            promise.reject err

        promise.promise   


module.exports = OpenerpClient