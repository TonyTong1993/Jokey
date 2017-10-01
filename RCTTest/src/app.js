'use strict';

import React, { Component } from 'react';

import {
  View,
  Text,
} from 'react-native';
import codePush from 'react-native-code-push' 
import App from './RouteConfig.js'
let codePushOptions = { checkFrequency: codePush.CheckFrequency.ON_APP_RESUME };
let MyApp = codePush(codePushOptions)(App);
export default MyApp;
