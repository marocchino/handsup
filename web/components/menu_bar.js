import React from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import { AppBar } from 'material-ui';

const MenuBar = () => (
  <MuiThemeProvider>
    <AppBar title="Handsup" />
  </MuiThemeProvider>
)
export default MenuBar
