'use strict';

import React, { Component } from 'react';
import { Provider } from 'react-redux';
import store from './configStore';
import {
  View,
  Text,
} from 'react-native';
import App from './RouteConfig'
const Root = ()=>{
	return (<Provider store={store}><App /></Provider>)
}
export default Root;
