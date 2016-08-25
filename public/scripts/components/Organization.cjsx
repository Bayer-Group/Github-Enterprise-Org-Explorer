React = require 'react'
{Card, CardHeader, CardText, CardActions} = require 'material-ui/Card'
FlatButton = require('material-ui/FlatButton').default
Paper = require('material-ui/Paper').default
OrgAvatar = require './OrgAvatar'

Organization = React.createClass
    displayName: 'Org'
    render: ->
        <Paper zDepth={3} style={marginBottom: 30}>
            <Card>
                <CardHeader title={@props.displayName} avatar={<OrgAvatar {...@props}/>}/>
                <CardText>{@props.description or <i><small>No description provided by organization owner.</small></i>}</CardText>
                <CardActions>
                    <FlatButton
                        label="Details"
                        secondary={true}
                        href={"/org/#{@props.login}"}
                    />
                    <FlatButton
                        label={<i className={'fa fa-github fa-2x'} style={marginTop: 4} />}
                        primary={true}
                        href={@props.githubUrl}
                    />
                </CardActions>
            </Card>
        </Paper>

module.exports = Organization
