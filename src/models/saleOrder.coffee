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
            orderId, fields)

    updateOrder: (orderId, lines, pricelist_id, partner_id, fields) ->

        if !fields            
            fields = @fields
            fields.push ["order_line"]...

        @connector.execute('external.adapter.sale.order', 'write_order',
            orderId, lines, pricelist_id, partner_id, fields)
   


module.exports = OeSaleOrder