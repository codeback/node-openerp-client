###
Unit test del cliente OpenERP
###

# External dependencies
chai = require "chai"
expect = chai.expect
Q = require "q"
xmlrpc = require "xmlrpc"

# Internal dependencies
Openerp = require "../../src/openerpClient"
Common = require "../../src/models/common"
server = require "../fixtures/mockServer"
conf = require("../fixtures/conf").conf
dummy = require("../fixtures/conf").dummyData

chai.should()

describe "Common", ->

    @timeout(4000)

    initData = 
        dbname: conf.dbname
        hostname: conf.hostname
        port: conf.port

    oeClient = null
    common = null

    before (done) -> 
        
        username = conf.username
        password = conf.password

        oeClient = new Openerp initData
        oeClient.login(username, password).then (userId) =>                
            common = new Common oeClient.connector, "product.product"
            done() 

    describe "create", ->

        it "debe crear un nuevo elemento", (done) ->

            product =
                name: "new product"
                categ_id: 1

            common.create(product).then (newId) => 
                newId.should.equal dummy.testId
                done()               
            .done()

    describe "search", ->

        it "debe devolver los elementos que cumplan la condición", (done) ->

            args = [
                ['type', '=', 'product'],
                ['list_price', '<', '100']
            ]
                
            common.search(args).then (ids) => 
                ids.length.should.equal dummy.itemIds.length
                done()             
            .done()
        
    describe "read", ->

        it "debe devolver los elementos pasados como ids ", (done) ->
            common.read([3], ["list_price"]).then (data) => 
                data[0].list_price.should.equal dummy.price     
                done()               
            .done()

    describe "write", ->

        it "debe actualizar los elementos pasados como ids ", (done) ->
            
            data = 
                list_price: 50
                type: 'consu'

            common.search([]).then((ids) => 
                numItems = ids.length

                ids = ids.sort (a,b) ->
                    parseInt(a,10) - parseInt(b,10)

                common.write([ids[ids.length - 1]], data)
            ).then (res) => 
                res.should.equal true
                done()               
            .done()

    describe "unlink", ->

        it "debe eliminar los elementos pasados como ids ", (done) ->

            numItems = null

            common.search([]).then((ids) => 
                numItems = ids.length

                ids = ids.sort (a,b) ->
                    parseInt(a,10) - parseInt(b,10) 

                common.unlink([ids[ids.length - 1]])
            ).then((res) => 
                res.should.equal true

                common.search([])
            ).then (ids) =>                 
                ids.length.should.equal numItems-1
                done()
            .done()
    