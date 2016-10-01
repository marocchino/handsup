import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import { RaisedButton } from 'material-ui';

const App = () => (
  <MuiThemeProvider>
    <RaisedButton label="Default" />
  </MuiThemeProvider>
)

export default App
