###

###

# External dependencies
Q = require "q"

# Internal dependencies
Common = require "./common"

class OeProduct extends Common

    constructor: (@connector) ->        
        @fields = ["name_template", "categ_id", "qty_available", "supply_method", "default_code", "image_small"]
         
        fields = @fields.slice(0)
        fields.push ["web_visible", "image", "product_technical_specifications_ids", "dimensions_sheet", "weight_sheet", 
          "description_sheet", "structure_sheet", "base_sheet", "gas_sheet", "wheels_sheet", "seat_interior_sheet", 
          "back_interior_sheet", "seat_exterior_sheet", "back_exterior_sheet", "mechanism_sheet",
          "finishes_sheet", "size_sheet", "box_size_sheet", "min_purchase_sheet", "box_volume_sheet"]...

        super @connector, "product.product", fields
        
    getProducts: (priceListId, partnerId, args, fields) =>
        if !fields
            fields = @fields.slice(0) 
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
