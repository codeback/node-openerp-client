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
OeProduct = require "../../src/models/product"
server = require "../fixtures/mockServer"
conf = require("../fixtures/conf").conf
dummy = require("../fixtures/conf").dummyData

chai.should()

describe "OeProduct", ->

    @timeout(4000)

    initData = 
        dbname: conf.dbname
        hostname: conf.hostname
        port: conf.port

    oeClient = null
    client = null

    before (done) -> 
        
        username = conf.username
        password = conf.password

        oeClient = new Openerp initData
        oeClient.login(username, password).then (userId) =>                
            client = new OeProduct oeClient.connector
            done() 

    describe "getProducts", ->

        it "debe obtener los productos pasados como Id", (done) ->

            priceListId = 12
            partnerId = 114

            client.getProducts(priceListId, partnerId).then (products) =>
                console.log products
                products[0].price.should.equal dummy.price 
                done()               
            .done()

    describe "getRelatedProducts", ->

        it "debe obtener los productos relacionados con el producto pasado como Id", (done) ->

            prodId = 3
            fields = ["name", "default_code"]

            client.getRelatedProducts(prodId, fields).then (products) =>
                products[0].name.should.equal dummy.name 
                done()               
            .done()

            