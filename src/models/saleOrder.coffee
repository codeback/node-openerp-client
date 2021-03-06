###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeSaleOrder extends Common

    partner = null

    constructor: (@connector) ->        
        @fields = ["state", "date_order", "name", "amount_untaxed", "invoice_ids", "user_id"]
        super @connector, "sale.order", @fields

    getByPartner: (partnerId, fields) ->
        fields ?= @fields 

        @connector.execute('external.adapter.sale.order', 'get_by_partner',
            partnerId, fields)

    getByPartnerAndMonth: (partnerId, fields) ->
        fields ?= @fields 

        @connector.execute('external.adapter.sale.order', 'get_by_partner_and_month',
            partnerId, fields)

    getOrder: (orderId, fields) ->

        if !fields            
            fields = @fields
            fields.push ["order_line", "amount_total"]...

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
   
    confirmOrder: (orderId, comments) =>        
        if comments
            promise = Q.defer()

            @write [parseInt(orderId)], 
                note: comments
            .then(() =>
                @connector.execute('sale.order', 'action_button_confirm',
                    [parseInt(orderId)])
            ).then(() =>
                promise.resolve()
            ).fail (err) =>
                promise.reject err

            return promise.promise
        else
            @connector.execute('sale.order', 'action_button_confirm',
                    [parseInt(orderId)])

    getInvoicePdf: (orderId, partnerId) ->        
        @connector.execute('external.adapter.sale.order', 'get_invoice_pdf',
            [parseInt(orderId)], partnerId)

module.exports = OeSaleOrder