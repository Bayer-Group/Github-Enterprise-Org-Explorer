express = require 'express'
router = express.Router()
_ = require 'underscore'
humanize = require 'underscore.string/humanize'
titleize = require 'underscore.string/titleize'
ltrim = require 'underscore.string/ltrim'
rtrim = require 'underscore.string/ltrim'
Agent = -> require('superagent-promise')(require('superagent'), Promise)
dotenv = require 'dotenv'

dotenv.load()

stripGithubUrlIfNeeded = (value) ->
    if not value?.startsWith "https://#{process.env.github_url}"
        value
    else
        value.slice "https://#{process.env.github_url}".length

sort = ({sortBy, desc}, results) ->
    results = [].concat results
    if sortBy
        results = _(results).sortBy (org) -> "#{org[sortBy]}".toLowerCase()
    if desc
        results = results.reverse()
    results.map (org) ->
        org = _(org).pick ['login', 'id', 'description', 'avatar_url']
        org.displayName = titleize humanize org.login
        org.githubUrl = "https://#{process.env.github_url}/#{org.login}"
        org

getMoreOrgs = (start, acum, callback) ->
    per_page = 100
    agent = Agent()
    agent.get "https://#{process.env.github_url}/api/v3/organizations"
    .auth process.env.github_user, process.env.github_pac
    .query
        since: start
        per_page: per_page
    .then ({body}) ->
        acum = acum.concat body
        if body.length < per_page
            callback acum
        else
            getMoreOrgs body[body.length-1].id, acum, callback

router.get '/orgs', (req, res) ->
    getMoreOrgs 0, [], (body) ->
        res.json sort req.query, body
    .catch (error) ->
        console.error error
        res.status(500).send error

router.get '/orgs/:login', (req, res) ->
    agent = Agent()
    orgPromise = agent.get "https://#{process.env.github_url}/api/v3/orgs/#{req.params.login}"
    .auth process.env.github_user, process.env.github_pac

    membersPromise = agent.get "https://#{process.env.github_url}/api/v3/orgs/#{req.params.login}/members"
    .auth process.env.github_user, process.env.github_pac
    .query per_page: 1000

    Promise.all [orgPromise, membersPromise]
    .then ([orgResults, membersResults]) ->
        org = orgResults.body
        org.displayName = titleize humanize org.login
        members = _(membersResults.body).filter (member) -> not member.site_admin
        admins = _(membersResults.body).filter (member) -> member.site_admin
        res.json {org, members, admins}
    .catch (error) ->
        console.error error
        res.status(500).send error
module.exports = router
