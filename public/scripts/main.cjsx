React = require 'react'
ReactDOM = require 'react-dom'
{Router, browserHistory} = require 'react-router'
routes = require './components/routes'
(require 'react-tap-event-plugin')()


ReactDOM.render <Router routes={routes} history={browserHistory}/>, document.querySelector('.contents')
