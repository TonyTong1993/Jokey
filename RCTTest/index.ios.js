'use strict';

import React from 'react';
import App from './src/app'
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  NativeModules,
} from 'react-native';
// var RNModules = NativeModules.TYRCTModule;
// class test extends React.Component {
//   render() {
//     return (
//      <GameScreen content={this.props.content} onClick={()=>RNModules.RNOpenOneVC('测试')}/>
//     )
//   }
// }
// var styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     justifyContent: 'center',
//   },
//   hello: {
//     fontSize: 20,
//     textAlign: 'center',
//     margin: 10,
//   },
// });

AppRegistry.registerComponent('test', () => App);
