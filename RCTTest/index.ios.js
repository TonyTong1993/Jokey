'use strict';

import React from 'react';
import App from './src/app';
import { Provider } from 'react-redux'
import store from './src/configStore'
import { LOGIN,GetMovies,LOGIN_TYPE_NORMAL,LOGIN_TYPE_THIRD } from './src/actions/LoginAction'
import {
  AppRegistry,

} from 'react-native';

// store.dispatch(GetMovies('https://facebook.github.io/react-native/movies.json')).then(() =>
//   console.log(store.getState())
// );

const app = ()=>{
	return (<Provider store={store}><App /></Provider>)
}
AppRegistry.registerComponent('test', () =>app);
