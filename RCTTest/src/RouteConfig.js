/* @flow */
/*自定义 navigation header*/
import React, { Component } from 'react';
import {
  View,
  Text,
  Button,
  StyleSheet,
  Image,
  Platform,
  TextInput,
} from 'react-native';
const TYRCTModule = require('NativeModules').TYRCTModule
import { TabNavigator,StackNavigator } from 'react-navigation'
import SearchHeader from './components/SearchHeader'
import { onePixel,screen_width } from './Config'
import HomePage from './pages/HomePage.js'
import CategoryPage from './pages/CategoryPage.js'
import CartPage from './pages/CartPage.js'
import ProfilePage from './pages/ProfilePage.js'
import SearchPage from './pages/SearchPage.js'

/*设置路由*/
const RootTabBarNavigator = TabNavigator({
  Home:{
    screen:HomePage,
    navigationOptions:()=>({
      // title:'Home'
      tabBarLabel:'首页',
      tabBarIcon:({focused,tintColor})=> (
        focused ?
        <Image source={{uri:'tab_home_selected'}} style={styles.icon}/>
        :
        <Image source={{uri:'tab_home_normal'}} style={styles.icon}/>
      )
    })
  },
  Category:{
    screen:CategoryPage,
    navigationOptions:()=>({
      tabBarLabel:'分类',
      tabBarIcon:({focused,tintColor})=> (
        focused ?
        <Image source={{uri:'tab_category_selected'}} style={styles.icon}/>
        :
        <Image source={{uri:'tab_category_normal'}} style={styles.icon}/>
      )
    })
  },
  Cart:{
    screen:CartPage,
    navigationOptions:()=>({
      tabBarLabel:'购物车',
      tabBarIcon:({focused,tintColor})=> (
        focused ?
        <Image source={{uri:'tab_cart_selected'}} style={styles.icon}/>
        :
        <Image source={{uri:'tab_cart_normal'}} style={styles.icon}/>
      )
    })
  },
  Profile:{
    screen:ProfilePage,
    navigationOptions:()=>({
      tabBarLabel:'我的',
      tabBarIcon:({focused,tintColor})=> (
        focused ?
          <Image source={{uri:'tab_profile_selected'}} style={styles.icon}/>
        :
          <Image source={{uri:'tab_profile_normal'}} style={styles.icon}/>
      )
    })
  }
},{
  // tabBarPosition:'top',
  tabBarOptions:{
    activeTintColor:'#F8453C',
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
  },
 lazy:true,
})


const RootStackNavigator = StackNavigator({
   Root:{screen:RootTabBarNavigator},
   Search:{screen:SearchPage}
},{
  navigationOptions:({navigation})=>{

    return {
      /*全局设置返回*/
      headerLeft: navigation.state.routeName =='Root'? null: <Text onPress={()=>navigation.goBack()}>返回</Text>,
        /*全局设置返回位置*/
      headerStyle:{paddingLeft:20}
    }
  },
  onTransitionStart:(params)=>{
    console.log(params.index)
    if (Platform.OS === 'android') {

    }else {
     TYRCTModule.rnGetPoprolengNotification({length:params.index})
    }
  },
  headerMode:'screen'
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

export default RootStackNavigator
