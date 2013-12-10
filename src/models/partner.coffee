###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OePartner extends Common

    constructor: (@connector) ->
        super @connector, "res.partner"

        @fields = ["name", "comercial", "image", "street", "street2", "city",
            "state_id", "zip", "country_id", "website", "phone", "mobile", "fax",
            "email", "property_product_pricelist"]

    read: (ids, fields) =>
        fields ?= @fields
        super ids, fields

module.exports = OePartner