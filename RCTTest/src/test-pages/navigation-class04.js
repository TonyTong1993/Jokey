'use strict';
/*Configuring the Header*/
import React, { Component } from 'react';

import {
  View,
  Text,
  Button
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
  static navigationOptions = ({navigation}) =>{
    const { state,setParams } = navigation;
    const isInfo = state.params.mode === 'info';
    const { user } = state.params;

    return {
      title: `Chat with ${navigation.state.params.user}`,
      headerRight: <Button title={isInfo ? 'Done' :`${user}'info'`} onPress={()=>setParams({
        mode:isInfo ? 'none':'info'
      })}/>
    }
  };
  render() {
    const { params } = this.props.navigation.state;
    return <Text>Chat With {params.user}</Text>;
  }
}

class RecentChatScreen extends React.Component {
  static navigationOptions = ({navigation}) =>({
    title: '最近联系的',
  });
  render() {
    return <Text>Recent Chat</Text>;
  }
}

const MianTabNavigator = TabNavigator({
  Home:{screen:HomeScreen},
  Recent:{screen:RecentChatScreen},
})
const App = StackNavigator({
      Home:{screen:MianTabNavigator},
      Chat:{screen:ChatScreen}                              
});

export default App;
