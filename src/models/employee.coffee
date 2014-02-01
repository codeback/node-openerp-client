###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeEmployee extends Common

    constructor: (@connector) ->        
        @fields = ["name", "work_email", "work_phone", "image_small"]

        super @connector, "hr.employee", @fields

module.exports = OeEmployee
