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
OePartner = require "../../src/models/partner"
server = require "../fixtures/mockServer"
conf = require("../fixtures/conf").conf
dummy = require("../fixtures/conf").dummyData

chai.should()

describe "OePartner", ->

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
            client = new OePartner oeClient.connector
            done() 

    describe "read", ->

        it "debe obtener la info por defecto del partner pasado como Id", (done) ->
            partnerId = 114

            client.read(partnerId).then (partner) =>
                partner.name.should.equal "ACME"
                done()               
            .done()

    describe "login", ->

        it "debe acceder correctamente", (done) ->
            client.login("acme", "123456").then (partner) =>
                partner.name.OpenERP.Partnershould.equal "ACME"
                done()
            .done()

        it "no debe acceder si el usuario no existe", (done) ->
            client.login("noexiste", "123456").fail (err) =>
                err.message.should.equal "user not found"
                done()
            .done()

        it "no debe acceder si el password es incorrecto", (done) ->
            client.login("acme", "654321").fail (err) =>
                err.message.should.equal "incorrect password"
                done()
            .done()
