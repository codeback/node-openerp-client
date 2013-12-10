###
Unit test del cliente OpenERP
###

# External dependencies
chai = require "chai"
expect = chai.expect
Q = require "q"
xmlrpc = require "xmlrpc"

# Internal dependencies
Openerp = require "../src/openerpClient"
server = require "./fixtures/mockServer"
conf = require("./fixtures/conf").conf
dummy = require("./fixtures/conf").dummyData

chai.should()

describe "OpenerpClient", ->

    @timeout(4000)
    
    initData = 
        dbname: conf.dbname
        hostname: conf.hostname
        port: conf.port

    oeClient = null

    before (done) -> 
        
        oeClient = new Openerp initData

        done()

    describe "login", ->

        it "debe devolver el userid", (done) ->

            username = conf.username
            password = conf.password

            oeClient.login(username, password).then (userId) =>                
                userId.should.equal dummy.testId     
                done()               
            .done()
    