'use strict';
/*基础使用*/
import React, { Component } from 'react';

import {
  View,
  Text,
} from 'react-native';
import { StackNavigator,TabNavigator } from 'react-navigation'

class HomeScreen extends React.Component {
  static navigationOptions = {
    title: 'Welcome',
  };
  render() {
    const  { navigate } = this.props.navigation;
    return <Text onPress={()=>{
        navigate('SecondScreen')
    }}>Hello, Navigation!</Text>;
  }
}
class SecondScreen extends React.Component {
  static navigationOptions = {
    title: 'SecondScreen',
  };
  render() {
    return <Text>Hello, Navigation!</Text>;
  }
}

const App = StackNavigator({
      Home:{screen:HomeScreen},
      SecondScreen:{screen:SecondScreen}                              
});


export default App;
