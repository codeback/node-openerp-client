###
Unit test del cliente OpenERP
###

# Dependencias externas
chai = require "chai"
expect = chai.expect
Q = require "q"
xmlrpc = require "xmlrpc"

# Dependencias internas
Openerp = require "../src/client"

chai.should()

describe "Openerp", ->

    initData = 
        dbname: "test"
        hostname: "localhost"
        port: 9889
        user: "testUser"
        passwd: "123456"

    userTestId = 111

    before (done) ->        

        
        server = xmlrpc.createServer
            host: initData.host
            port: initData.port

        server.on "login", (err, params, callback) ->
            callback null, userTestId
        
        done()

    describe "Login", ->

        oeClient = null

        before (done) ->
            oeClient = new Openerp initData
            done()

        it "debe devolver el userid", (done) ->
            oeClient.login("user", "123456").then (userId) =>
                userId.should.equal userTestId
                done()
            .done()