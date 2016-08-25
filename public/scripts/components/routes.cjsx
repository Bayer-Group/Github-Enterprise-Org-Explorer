React = require 'react'
{Route, IndexRoute, withRouter} = require 'react-router'
RootComponent = withRouter require './RootComponent'
PlaceHolder = withRouter require './PlaceHolder'
Organizations = withRouter require './Organizations'
OrgDetails = withRouter require './OrgDetails'
module.exports =
    <Route path={'/'} component={RootComponent}>
        <IndexRoute component={Organizations} />
        <Route path={'org/:login'} component={OrgDetails}/>
    </Route>
