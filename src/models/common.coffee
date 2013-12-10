###

###

class Common

    constructor: (@connector, @model) ->

    create: (fields) =>
        @connector.execute(@model, 'create', fields)

    search: (args, offset=0, limit=1000) =>
        @connector.execute(@model, 'search', args, offset, limit)

    read: (ids, fields) =>
        @connector.execute(@model, 'read', ids, fields)

    write: (ids, data) =>
        @connector.execute(@model, 'write', ids, data)

    unlink: (ids) =>
        @connector.execute(@model, 'unlink', ids)

module.exports = Common