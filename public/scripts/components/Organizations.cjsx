React = require 'react'
SelectField = require('material-ui/SelectField').default
MenuItem = require('material-ui/MenuItem').default
Paper = require('material-ui/Paper').default
TextField = require('material-ui/TextField').default
CircularProgress = require('material-ui/CircularProgress').default
agent = require 'superagent'
(require 'superagent-as-promised')(agent)
Org = require './Organization'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'
include = require 'underscore.string/include'

Organizations = React.createClass
    displayName: 'Organizations'
    getInitialState: ->
        orgs: []
        sortBy: 'login'
        orgFilter: ''
        loading: true
    getOrgs: ->
        agent.get '/api/orgs'
        .query sortBy: @state.sortBy
        .then ({body}) =>
            @setState
                orgs: body
                loading: false
    componentDidMount: ->
        @getOrgs()
    changeSortBy: (proxy, index, value) ->
        @setState sortBy: value
        setTimeout @getOrgs, 0
    setOrgFilter: (event) ->
        @setState orgFilter: event.target.value
    filterOrgs: (org) ->
        if @state.orgFilter isnt ''
            include org.displayName.toLowerCase(), @state.orgFilter.toLowerCase()
        else
            true
    render: ->
        if @state.loading
            <CircularProgress style={paddingTop: 25, marginLeft: 'auto', marginRight: 'auto', display: 'block'}/> 
        else
            <div>
                <Paper zDepth={2} style={marginTop: 20, marginBottom: 30, paddingLeft: 10, paddingRight: 10}>
                    <div className={'row'} style={marginBottom: 10}>
                        <div className={'col-xs-12 col-sm-6 col-md-4 col-lg-3'}>
                            <TextField
                                onChange={@setOrgFilter}
                                fullWidth={true}
                                floatingLabelText={<span><i className='fa fa-search'></i> By Name:</span>}
                                floatingLabelStyle={color: @props.theme.palette.primary1Color}
                            />
                        </div>
                        <div className={'col-xs-12 col-sm-6 col-md-4 col-lg-3'}>
                            <SelectField
                                value={@state.sortBy}
                                onChange={@changeSortBy}
                                floatingLabelText={'Sort By:'}
                                floatingLabelStyle={'color': @props.theme.palette.primary1Color}
                                fullWidth={true}
                            >
                                <MenuItem value={'login'} primaryText='Name' />
                                <MenuItem value={'id'} primaryText='Creation Order' />
                            </SelectField>
                        </div>
                    </div>
                </Paper>
                <ReactCSSTransitionGroup transitionName="orgs" transitionEnterTimeout={500} transitionLeaveTimeout={300} className={'row'}>
                    {
                        @state.orgs.filter(@filterOrgs).map (org) =>
                          <div className='col-xs-12 col-sm-6 col-md-4 col-lg-3' key={org.id}>
                              <Org {...org} router={@props.router}/>
                          </div>
                    }
                </ReactCSSTransitionGroup>
            </div>


module.exports = Organizations
