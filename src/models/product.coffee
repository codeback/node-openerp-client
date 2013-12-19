###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeProduct extends Common

    constructor: (@connector) ->        
        @fields = ["name_template"]
        super @connector, "product.product", @fields
        
    getProducts: (priceListId, partnerId) =>
        @connector.execute('external.adapter.product', 'get_products',
            @fields, priceListId, partnerId)

    getRelatedProducts: (prodId, fields) =>

        fields ?= @fields 

        @connector.execute('external.adapter.product', 'get_related_products',
            prodId, fields)

module.exports = OeProduct



