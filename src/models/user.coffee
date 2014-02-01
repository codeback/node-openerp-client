###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeUser extends Common

    constructor: (@connector) ->        
        @fields = ["employee_ids"]

        super @connector, "res.users", @fields

module.exports = OeUser
