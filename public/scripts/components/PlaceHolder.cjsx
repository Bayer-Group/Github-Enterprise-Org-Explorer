React = require 'react'

RootComponent = (props) ->
    <div>
        <div>{JSON.stringify props}</div>
        {props.children}
    </div>

RootComponent.displayName = 'PlaceHolder'

module.exports = RootComponent
