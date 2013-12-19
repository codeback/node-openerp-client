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
OeSaleOrder = require "../../src/models/saleOrder"
server = require "../fixtures/mockServer"
conf = require("../fixtures/conf").conf
dummy = require("../fixtures/conf").dummyData

chai.should()

describe "OeSaleOrder", ->

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
            client = new OeSaleOrder oeClient.connector
            done() 

    describe "getByPartner", ->

        it "debe obtener los órdenes de un partner", (done) ->

            partnerId = 114

            client.getByPartner(partnerId).then (orders) =>
                console.log orders
                orders.length.should.above 0
                done()               
            .done()

    

            