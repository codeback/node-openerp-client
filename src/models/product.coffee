###

###

# External dependencies

# Internal dependencies
Common = require "./common"

class OeProduct extends Common

    constructor: (@connector) ->
        super @connector, "product.product"


module.exports = OeProduct



