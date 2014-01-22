###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OePartner extends Common

    partner = null

    constructor: (@connector) ->        
        @fields = ["name", "comercial", "image_medium", "image", "street", "street2", "city",
            "state_id", "zip", "country_id", "website", "phone", "mobile", "fax",
            "email", "vat"]

        super @connector, "res.partner", @fields

    login: (username, password) =>

        promise = Q.defer()

        @connector.execute('external.adapter.partner', 'login',
            username, password).then (res) =>
                if res.status == 200                
                    @partner = res.data
                    promise.resolve @partner
                else
                    promise.reject new Error res.message
        .fail (err) =>
            promise.reject err

        promise.promise


module.exports = OePartner