###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeCompany extends Common

    constructor: (@connector) ->        
        @fields = ["web_discount"]

        super @connector, "res.company", @fields

module.exports = OeCompany