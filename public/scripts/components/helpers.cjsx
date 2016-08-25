React = require 'react'
Chip = require('material-ui/Chip').default
Avatar = require('material-ui/Avatar').default

exports.mapMember = (member) ->
    <a href={member.html_url} key={member.id}>
        <Chip style={float: 'left', marginRight: 15, marginBottom: 10, cursor: 'pointer'}>
            <Avatar src={member.avatar_url}/>
            {member.login}
        </Chip>
    </a>
