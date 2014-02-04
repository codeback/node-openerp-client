###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeGlobalSales extends Common

    constructor: (@connector) ->        
        @fields = ["user_id","product_id","product_uom_qty", "price_total", "shipped_qty_1"]

        super @connector, "sale.report", @fields

module.exports = OeGlobalSales