###
    
###

# External dependencies
xmlrpc = require 'xmlrpc'
Q = require 'q'

class Connector

    constructor: (@dbname, @hostname, @port) ->
        @url = 'http://'+hostname+':'+port+'/xmlrpc'
        
        @common = 
            host: @hostname
            port: @port
            path:'/xmlrpc/common'

        @object =
            host: @hostname
            port: @port
            path:'/xmlrpc/object'
        
        @rpc_common = xmlrpc.createClient @common
        @rpc_object = xmlrpc.createClient @object

        @commonCall = Q.nbind @rpc_common.methodCall, @rpc_common
        @objectCall = Q.nbind @rpc_object.methodCall, @rpc_object

    setUser: (@uid, @passwd) =>

    getParams: () =>
        [@dbname, @uid, @passwd]

    execute: (model, action, args...) =>       

        params = @getParams()
        params.push [model, action]...
        params.push args...

        @objectCall('execute', params)


module.exports = Connector
