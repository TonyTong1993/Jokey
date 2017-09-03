'use strict';

import React from 'react';
import App from './src/app';
import { Provider } from 'react-redux'
import store from './src/configStore'
import { LOGIN,GetMovies,LOGIN_TYPE_NORMAL,LOGIN_TYPE_THIRD } from './src/actions/LoginAction'
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

store.dispatch(GetMovies('https://facebook.github.io/react-native/movies.json')).then(() =>
  console.log(store.getState())
);

const app = ()=>{
	return (<Provider store={store}><App /></Provider>)
}
AppRegistry.registerComponent('test', () =>app);
