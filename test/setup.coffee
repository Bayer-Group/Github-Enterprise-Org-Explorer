chai = require 'chai'
global.should = chai.should()
chai.use require('chai-as-promised')
chai.use require('sinon-chai')
global.sinon = require 'sinon'
require 'sinon-as-promised'

process.env.github_url = 'localhost:9999'

global.mockery = require 'mockery'
mockery.enable
    warnOnReplace: false
    warnOnUnregistered: false

global.Test = (done) ->
    (callback) ->
        try
            callback()
            done()
        catch error
            done(error)
