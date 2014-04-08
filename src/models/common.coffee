###

###

class Common

    constructor: (@connector, @model, @readFields) ->

    create: (data) =>
        @connector.execute(@model, 'create', data)

    search: (args, offset=0, limit=1000) =>
        @connector.execute(@model, 'search', args, offset, limit)

    read: (ids, fields, context) =>
        fields ?= @readFields
        context ?= {}

        context.lang = "es_ES"

        @connector.execute(@model, 'read', ids, fields, context)

    write: (ids, data) =>
        @connector.execute(@model, 'write', ids, data)

    unlink: (ids) =>
        @connector.execute(@model, 'unlink', ids)

module.exports = Common