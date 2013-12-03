# Dependencias externas
xmlrpc = require 'xmlrpc'

class Connector

    constructor: (@dbname, @hostname, @port, @user, @passwd) ->
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

    getParams: () =>
        [@dbname, @user, @passwd]


module.exports = Connector






