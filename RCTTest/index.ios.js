'use strict';

import React from 'react';
// import App from './src/app';//项目入口
import LeanStoragePage from './src/test-pages/lean-storage-class/lean-storage-class-01';//测试入口
import {
  AppRegistry,
} from 'react-native';

AppRegistry.registerComponent('test', () =>LeanStoragePage);
