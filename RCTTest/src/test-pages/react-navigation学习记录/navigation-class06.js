/* @flow */
/*TabNavigator */
import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Image,
} from 'react-native';
import { TabNavigator } from 'react-navigation'
import { onePixel } from '../Config'
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
      // title:'Home'
      tabBarLabel:'Home',
      tabBarIcon:({focused,tintColor})=> (
        focused ?
        <Image source={require('../imgs/tab/home_on@3x.png')} style={styles.icon}/>
        :
        <Image source={require('../imgs/tab/home_off@3x.png')} style={styles.icon}/>
      )
    })
  },
  Contact:{
    screen:ContactScreen,
    navigationOptions:()=>({
      tabBarLabel:'Contact',
      tabBarIcon:({focused,tintColor})=> (
        focused ?
        <Image source={require('../imgs/tab/category_on@3x.png')} style={styles.icon}/>
        :
        <Image source={require('../imgs/tab/category_off@3x.png')} style={styles.icon}/>
      )
    })
  },
  Discover:{
    screen:DiscoverScreen,
    navigationOptions:()=>({
      tabBarLabel:'Discover',
      tabBarIcon:({focused,tintColor})=> (
        focused ?
        <Image source={require('../imgs/tab/discover_on@3x.png')} style={styles.icon}/>
        :
        <Image source={require('../imgs/tab/discover_off@3x.png')} style={styles.icon}/>
      )
    })
  },
  Profile:{
    screen:ProfileScreen,
    navigationOptions:()=>({
      tabBarLabel:'Profile',
      tabBarIcon:({focused,tintColor})=> (
        focused ?
          <Image source={require('../imgs/tab/cart_on@3x.png')} style={styles.icon}/>
        :
          <Image source={require('../imgs/tab/cart_off@3x.png')} style={styles.icon}/>
      )
    })
  }
},{
  // tabBarPosition:'top',
  tabBarOptions:{
    activeTintColor:'#0bad61',
    // showLabel:false
    // activeBackgroundColor:'#0bad61'
     style: {
          backgroundColor: '#fff', // TabBar 背景色
          borderTopWidth:onePixel,//ios 中的shadow image
          borderTopColor: '#e0e0e0',//更改颜色
      },
      labelStyle: {
             fontSize: 10, // 文字大小
         },
  }
})

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent:'center',
    alignItems:'center',
  },
  icon:{
    width:20,
    height:20,
  }
});

export default RootTabBarNavigator
