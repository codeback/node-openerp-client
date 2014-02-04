###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeSales extends Common

    constructor: (@connector) ->        
        @fields = ["partner_id","product_id","amount_sold"]

        super @connector, "crm.product.sold", @fields

module.exports = OeSales