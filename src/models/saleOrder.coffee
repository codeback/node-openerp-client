###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeSaleOrder extends Common

    partner = null

    constructor: (@connector) ->        
        @fields = ["state", "date_order", "name", "amount_untaxed"]
        super @connector, "sale.order", @fields

    getByPartner: (partnerId, fields) ->
        fields ?= @fields 

        @connector.execute('external.adapter.sale.order', 'get_by_partner',
            partnerId, fields)

    getOrder: (orderId, fields) ->

        if !fields            
            fields = @fields
            fields.push ["order_line"]...

        @connector.execute('external.adapter.sale.order', 'get_order',
            parseInt(orderId), fields)

    createOrder: (lines, pricelistId, partnerId) ->

        @connector.execute('external.adapter.sale.order', 'create_order',
            lines, pricelistId, partnerId)

    updateOrder: (orderId, lines, pricelistId, partnerId, fields) ->

        if !fields            
            fields = @fields
            fields.push ["order_line"]...

        @connector.execute('external.adapter.sale.order', 'write_order',
            parseInt(orderId), lines, pricelistId, partnerId, fields)
   
    confirmOrder: (orderId) ->        
        @connector.execute('sale.order', 'action_button_confirm',
            [parseInt(orderId)])

module.exports = OeSaleOrder