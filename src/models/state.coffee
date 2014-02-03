###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeState extends Common

    constructor: (@connector) ->        
        @fields = ["code","country_id","name"]

        super @connector, "res.country.state", @fields

module.exports = OeState