###
Unit test del cliente OpenERP
###

# Dependencias externas
chai = require "chai"
expect = chai.expect
Q = require "q"
xmlrpc = require "xmlrpc"

# Dependencias internas
Openerp = require "../src/openerpClient"

chai.should()

describe "OpenerpClient", ->

    initData = 
        dbname: "test"
        hostname: "localhost"
        port: 9889

    
    initData = 
        dbname: "cb-test"
        hostname: "codeback.es"
        port: 8001
    

    username = "javier"
    password = "javier"

    testId = 4
    oeClient = null

    before (done) -> 
                      
        server = xmlrpc.createServer
            host: initData.host
            port: initData.port

        server.on "login", (err, params, callback) ->
            callback null, testId
        
        oeClient = new Openerp initData

        done()

    describe "login", ->

        it "debe devolver el userid", (done) ->
            oeClient.login(username, password).then (userId) =>                
                userId.should.equal testId     
                done()               
            .done()

    describe "Product", ->

        describe "read", ->

            it "debe devolver los productos pasados como ids ", (done) ->
                oeClient.Product.read([3], ["list_price"]).then (data) => 
                    data[0].list_price.should.equal 100     
                    done()               
                .done()


    