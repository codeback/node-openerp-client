###

###

class Common

    constructor: (@connector, @model) ->

    read: (ids, fields) =>
        @connector.execute(@model, 'read', ids, fields)

module.exports = Common