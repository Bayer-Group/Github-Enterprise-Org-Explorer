httpMocks = require 'node-mocks-http'

describe 'API', ->
    {api, mockAgent} = {}
    beforeEach ->
        mockAgent = sinon.stub
            get: ->
            auth: ->
            query: ->
        mockery.registerMock 'superagent-promise', ->
            mockAgent
        api = require '../api'

    afterEach ->
        mockery.deregisterMock 'superagent-promise'

    it 'Can get orgs', (done) ->
        test = Test done
        mockAgent.get.returnsThis()
        mockAgent.auth.returnsThis()
        mockAgent.query.returns Promise.resolve body: [
                id: 1234
                login: 'testOrg'
            ]
        request = httpMocks.createRequest
            method: 'GET'
            url: '/orgs'
        response = httpMocks.createResponse(eventEmitter: require('events').EventEmitter)
        api(request, response)
        response.on 'end', -> test ->
            response._getData().should.eql '[{"login":"testOrg","id":1234,"displayName":"Test Org","githubUrl":"https://localhost:9999/testOrg"}]'

    it 'Can handle org paging', (done) ->
        test = Test done
        mockAgent.get.returnsThis()
        mockAgent.auth.returnsThis()
        mockAgent.query.onFirstCall().returns Promise.resolve body: [0...100].map (i) ->
                id: i
                login: "testOrg ##{i}"
        mockAgent.query.onSecondCall().returns Promise.resolve body: []
        request = httpMocks.createRequest
            method: 'GET'
            url: '/orgs'
        response = httpMocks.createResponse(eventEmitter: require('events').EventEmitter)
        api(request, response)
        response.on 'end', -> test ->
            mockAgent.query.should.have.been.calledTwice

    it 'Can return org details', (done) ->
        request = httpMocks.createRequest
            method: 'GET'
            url: '/orgs/some-org'
            params:
                login: 'some-org'
        response = httpMocks.createResponse(eventEmitter: require('events').EventEmitter)
        test = Test done
        mockAgent.get.withArgs("https://#{process.env.github_url}/api/v3/orgs/#{request.params.login}").returns
            auth: -> Promise.resolve
                body:
                    id: 1
                    login: 'some-org'
        mockAgent.get.withArgs("https://#{process.env.github_url}/api/v3/orgs/#{request.params.login}/members").returnsThis()
        mockAgent.auth.returnsThis()
        mockAgent.query.returns Promise.resolve
            body: [
                {id: 1}
                {id: 2, site_admin: true}
            ]
        api(request, response)
        response.on 'end', -> test ->
            results = JSON.parse response._getData()
            results.org.should.eql {"id":1,"login":"some-org","displayName":"Some Org"}
            results.members.should.eql [{"id":1}]
            results.admins.should.eql [{"id":2,"site_admin":true}]
            mockAgent.query.should.have.been.called
