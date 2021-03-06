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
import SearchHeader from '../components/SearchHeader'
import { onePixel,screen_width } from '../Config'
 class HomeScreen extends Component {
   static navigationOptions = ({navigation}) =>({
     header:()=>{
       return <SearchHeader />
     }
   })
  render() {
    return (
      <View style={styles.container}>
        <Button title='enter detail Screen' onPress={()=>{
          console.log(this.props.navigation.state)

          this.props.navigation.navigate('Detail')
        }}/>
      </View>
    );
  }
}
class ContactScreen extends Component {
  static navigationOptions = ({navigation}) =>({
    title:'Chat'
  })
 render() {
   return (
     <View style={styles.container}>
       <Text>I'm the ContactScreen component</Text>
     </View>
   );
 }
}

class DiscoverScreen extends Component {
  static navigationOptions = ({navigation}) =>({
    title:'Discover'
  })
 render() {
   return (
     <View style={styles.container}>
       <Text>I'm the DiscoverScreen component</Text>
     </View>
   );
 }
}
class ProfileScreen extends Component {
  static navigationOptions = ({navigation}) =>({
    title:'Profile'
  })
 render() {
   return (
     <View style={styles.container}>
       <Text>I'm the ProfileScreen component</Text>
     </View>
   );
 }
}
class DetailScreen extends Component {
  static navigationOptions = ({navigation}) =>({
    title:'DetailScreen'
  })

 render() {
   return (
     <View style={styles.container}>
       <Button title='enter Third Screen' onPress={()=>{
         this.props.navigation.navigate('Third')

       }}/>
     </View>
   );
 }
  componentDidMount() {
    console.log(this.props.navigation.state)
  }
}
class ThirdScreen extends Component {
  static navigationOptions = ({navigation}) =>({
    title:'ThirdScreen'
  })

 render() {
   return (
     <View style={styles.container}>
       <Text>I'm the ThirdScreen component</Text>
     </View>
   );
 }
  componentDidMount() {
    console.log(this.props.navigation.state)
  }
}





/*设置路由*/
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

const RootStackNavigator = StackNavigator({
   Root:{screen:RootTabBarNavigator},
   Detail:{screen:DetailScreen},
   Third:{screen:ThirdScreen}
},{
  onTransitionStart:(params)=>{
    console.log(params.index)
    if (Platform.OS === 'android') {

    }else {
     TYRCTModule.rnGetPoprolengNotification({length:params.index})
    }
  },
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
