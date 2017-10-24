'use strict';

import React from 'react';
//import App from './src/app';//项目入口
import ReduxPage from './src/test-pages/redux-class/redux-class-01';//测试入口
import {
  AppRegistry,
} from 'react-native';

AppRegistry.registerComponent('test', () =>ReduxPage);
