React = require 'react'
AppBar = require('material-ui/AppBar').default
FontIcon = require('material-ui/FontIcon').default
IconButton = require('material-ui/IconButton').default
MuiThemeProvider = require('material-ui/styles/MuiThemeProvider').default
getMuiTheme = require('material-ui/styles/getMuiTheme').default
baseTheme = require('material-ui/styles/baseThemes/lightBaseTheme').default
{history} = require 'react-router'

baseTheme.palette.primary1Color = '#005839'
baseTheme.palette.primary2Color = '#005839'
baseTheme.palette.accent1Color =  '#d46b21'
baseTheme.palette.accent2Color =  '#d46b21'
baseTheme.palette.accent3Color =  '#d46b21'

theme = getMuiTheme baseTheme

handleTouchTap = ->
    alert('onTouchTap triggered on the title component');

RootComponent = ({children, router}, context) ->
    homeButton = <IconButton iconClassName={'fa fa-home'} onTouchTap={-> router.push '/'}/>
    <MuiThemeProvider muiTheme={theme}>
        <div>
            <AppBar
                title={'GitHub Enterprise Organizations'}
                iconElementLeft={homeButton}
                zDepth={2}
            />
            {React.cloneElement children, {theme, router}}
        </div>
    </MuiThemeProvider>

RootComponent.displayName = 'RootComponent'

module.exports = RootComponent
