React = require 'react'
Avatar = require('material-ui/Avatar').default

OrgAvatar = React.createClass
    displayName: 'OrgAvatar'
    render: ->
        <Avatar
            color={'#000000'}
            backgroundColor={'#FFFFFF'}
            style={border: '1px solid rgba(188, 188, 188, 0.5)', marginRight: '16px'}
            src={@props['avatar_url']}
        />

module.exports = OrgAvatar
