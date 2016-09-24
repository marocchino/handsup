// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
// import "phoenix_html"
import React from 'react';
import ReactDOM from 'react-dom';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import { AppBar, RaisedButton } from 'material-ui';

const MenuBar = () => (
  <MuiThemeProvider>
    <AppBar title="Handsup" />
  </MuiThemeProvider>
)
const App = () => (
  <MuiThemeProvider>
    <RaisedButton label="Default" />
  </MuiThemeProvider>
)

ReactDOM.render(
  <App />,
  document.getElementById('app')
)
ReactDOM.render(
  <MenuBar />,
  document.getElementById('menu-bar')
)

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
