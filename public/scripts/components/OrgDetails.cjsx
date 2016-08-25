React = require 'react'
agent = require 'superagent'
_ = require 'underscore'
(require 'superagent-as-promised')(agent)
{mapMember} = require './helpers'
Avatar = require './OrgAvatar'
OrgDetailsTable = require './OrgDetailsTable'
FlatButton = require('material-ui/FlatButton').default
Paper = require('material-ui/Paper').default
CircularProgress = require('material-ui/CircularProgress').default
Subheader = require('material-ui/Subheader').default
IconButton = require('material-ui/IconButton').default
{Card, CardHeader, CardText, CardActions} = require 'material-ui/Card'
{List, ListItem} = require 'material-ui/List'
{Table, TableBody, TableHeader, TableHeaderColumn, TableRow, TableRowColumn} = require 'material-ui/Table'

OrgDetails = React.createClass
    displayName: 'OrgDetails'
    getInitialState: ->
        org: {}
        members: []
        loading: true
    componentDidMount: ->
        agent.get "/api/orgs/#{@props.params.login}"
        .query sortBy: @state.sortBy
        .then ({body}) =>
            @setState _(body).extend loading: false
    render: ->
        if @state.loading
            <CircularProgress style={paddingTop: 25, marginLeft: 'auto', marginRight: 'auto', display: 'block'}/>
        else
            <Paper zDepth={3} style={marginTop: 30}>
                <Card>
                    <CardHeader
                        title={@state.org.name or @state.org.displayName}
                        avatar={<Avatar {...@state.org}/>}
                        subtitle={<a href={"mailto:#{@state.org.email or @state.org['billing_email']}"}>{@state.org.email or @state.org['billing_email']}</a>}>
                        <a href={@state.org.html_url} style={color: 'black', position: 'absolute', right: 16}>
                            <i className={'fa fa-github fa-2x'}></i>
                        </a>
                    </CardHeader>
                    <CardText>
                        <div className={'row'}>
                            <Paper className={'col-xs-12'} style={marginBottom: 30}>
                                <p>
                                    {@state.org.description or <i><small>No description provided by organization owner.</small></i>}
                                </p>
                            </Paper>
                        </div>
                        <div className={'row'}>
                            <div className={'col-xs-12 col-sm-6 col-md-6 col-lg-6'}>
                                <Paper>
                                    <Subheader>General Information</Subheader>
                                    <OrgDetailsTable {...@state}></OrgDetailsTable>
                                </Paper>
                            </div>
                            <div className={'col-xs-12 col-sm-6 col-md-6 col-lg-6'}>
                                <Card initiallyExpanded={true} style={marginBottom: 15}>
                                    <CardHeader
                                        title={'Members'}
                                        actAsExpander={true}
                                        showExpandableButton={true}>
                                    </CardHeader>
                                    <CardText expandable={true}>
                                        {
                                            @state.members.map mapMember
                                        }
                                        <div style={clear: 'both'}/>
                                    </CardText>
                                </Card>
                                <Card>
                                    <CardHeader
                                        title={'GHE Admins'}
                                        subtitle={'GHE Admins may or may not actually be members of this org.'}
                                        subtitleStyle={color: @props.theme.palette.accent1Color}
                                        actAsExpander={true}
                                        showExpandableButton={true}>
                                    </CardHeader>
                                    <CardText expandable={true}>
                                        {
                                            @state.admins.map mapMember
                                        }
                                        <div style={clear: 'both'}/>
                                    </CardText>
                                </Card>
                            </div>
                        </div>
                    </CardText>
                </Card>
            </Paper>

module.exports = OrgDetails
