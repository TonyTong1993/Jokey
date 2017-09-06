/* @flow */

import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Image,
} from 'react-native';
import { TabNavigator } from 'react-navigation'
 class HomeScreen extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>I'm the HomeScreen component</Text>
      </View>
    );
  }
}
class ContactScreen extends Component {
 render() {
   return (
     <View style={styles.container}>
       <Text>I'm the ContactScreen component</Text>
     </View>
   );
 }
}

class DiscoverScreen extends Component {
 render() {
   return (
     <View style={styles.container}>
       <Text>I'm the DiscoverScreen component</Text>
     </View>
   );
 }
}
class ProfileScreen extends Component {
 render() {
   return (
     <View style={styles.container}>
       <Text>I'm the ProfileScreen component</Text>
     </View>
   );
 }
}
const RootTabBarNavigator = TabNavigator({
  Home:{
    screen:HomeScreen,
    navigationOptions:()=>({
      tabBarLabel:'Home',
      tabBarIcon:({tintColor})=> (
        <Image source={require('../imgs/tab/home_off@2x.png')} style={[styles.icon,{tintColor:tintColor}]}/>
      )
    })
  },
  Contact:{
    screen:ContactScreen,
    navigationOptions:()=>({
      tabBarLabel:'Contact',
      tabBarIcon:({tintColor})=> (
        <Image source={require('../imgs/tab/home_off@2x.png')} style={[styles.icon,{tintColor:tintColor}]}/>
      )
    })
  },
  Discover:{
    screen:DiscoverScreen,
    navigationOptions:()=>({
      tabBarLabel:'Discover',
      tabBarIcon:({tintColor})=> (
        <Image source={require('../imgs/tab/home_off@2x.png')} style={[styles.icon,{tintColor:tintColor}]}/>
      )
    })
  },
  Profile:{
    screen:ProfileScreen,
    navigationOptions:()=>({
      tabBarLabel:'Profile',
      tabBarIcon:({tintColor})=> (
        <Image source={require('../imgs/tab/home_off@2x.png')} style={[styles.icon,{tintColor:tintColor}]}/>
      )
    })
  }
},{
  // tabBarPosition:'top',
  tabBarOptions:{
    activeTintColor:'#ffb300',
    activeBackgroundColor:'#0bad61'
  }
})

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent:'center',
    alignItems:'center',
  },
  icon:{
    width:26,
    height:26,
  }
});

export default RootTabBarNavigator
