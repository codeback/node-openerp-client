###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeProduct extends Common

    constructor: (@connector) ->        
        @fields = ["name_template", "categ_id", "qty_available", "supply_method"]
         
        fields = @fields
        fields.push ["image", "product_technical_specifications_ids", "dimensions", "weight"]...

        super @connector, "product.product", fields
        
    getProducts: (priceListId, partnerId, args, fields) =>
        if !fields
            fields = @fields 
            fields.push "image_small"
            
        @connector.execute('external.adapter.product', 'get_products',
            priceListId, partnerId, args, fields)

    getRelatedProducts: (prodId, fields) =>
        fields ?= @fields 
        @connector.execute('external.adapter.product', 'get_related_products',
            prodId, fields)

    getSpecifications: (specIds) ->    
        fields = []
        fields.push "specification"
        @connector.execute('product.technical.specifications','read', specIds, fields)    

module.exports = OeProduct



