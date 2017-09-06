'use strict';
/*Pass Params*/
import React, { Component } from 'react';

import {
  View,
  Text,
} from 'react-native';
import { StackNavigator,TabNavigator } from 'react-navigation'

class HomeScreen extends React.Component {
  static navigationOptions = {
    title: '通讯录',
  };
  constructor(props) {
    super(props);

    this.state = {
      name:''
    };
  }
  render() {
    const  { navigate } = this.props.navigation;
    return (
       <View >
           <Text onPress = {
            () => {
              navigate('Chat',{user:'Arfago'})
            }
          } > Arfago
          </Text>
           <Text onPress = {
            () => {
              navigate('Chat',{user:'Blob'})
            }
          } >Blob</Text>
           <Text onPress = {
            () => {
              navigate('Chat',{user:'Cindy'})
            }
          } > Cindy
          </Text>
      </View>
      );
  }
}
class ChatScreen extends React.Component {
  static navigationOptions = ({navigation}) =>({
    title: `Chat with ${navigation.state.params.user}`,
  });
  render() {
    const { params } = this.props.navigation.state;
    return <Text>Chat With {params.user}</Text>;
  }
}

const App = StackNavigator({
      Home:{screen:HomeScreen},
      Chat:{screen:ChatScreen}                              
});


export default App;
