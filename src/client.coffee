
# Dependencias externas
Q = require 'q'

# Dependencias internas
Connector = require "./connector"

class Openerp

    constructor: ({dbname, hostname, port, user, passwd}) ->
        @connector = new Connector dbname, hostname, port, user, passwd


    login: (username, password) =>

        promise = Q.defer()

        params =  @connector.getParams()

        login = Q.nbind @connector.rpc_common.methodCall, @connector.rpc_common

        login('login', params).then (userId) =>
            promise.resolve userId
        .fail (err) =>
            promise.reject err

        promise.promise

module.exports = Openerp