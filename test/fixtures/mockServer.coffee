# External dependencies
xmlrpc = require "xmlrpc"

# Internal dependencies
conf = require("./conf").conf
dummy = require("./conf").dummyData

server = xmlrpc.createServer
            host: conf.hostname
            port: conf.port

server.on "login", (err, params, callback) ->
    callback null, dummy.testId

server.on "execute", (err, params, callback) ->

    model = params[3]
    action = params[4]

    if model == "product.product" 

        if action == "create" 
            callback null, dummy.testId

        if action == "search" 
            callback null, dummy.itemIds

        if action == "read" 
            res = [{list_price: dummy.price}]
            callback null, res

        if action == "write" 
            callback null, true

        if action == "unlink"
            dummy.itemIds = dummy.itemIds[0..1]
            callback null, true   

    if model == "external.adapter.product" 

        if action == "get_products" or "getRelatedProducts"
            res = [
                id: dummy.testId
                name_template: dummy.name_template
                price: dummy.price
            ,
                id: dummy.testId + 1
                name_template: dummy.name_template + " B"
                price: dummy.price   
            ]
                    
            callback null, res

module.exports = server