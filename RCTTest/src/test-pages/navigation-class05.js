/* @flow */
/*StackNavigator */
import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Button,
} from 'react-native';
import { StackNavigator } from 'react-navigation'
import HeaderTest from './components/HeaderTest'
const Header = (<HeaderTest />)
 class MyHomeScreen extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button
       onPress={() => this.props.navigation.navigate('Profile', {name: 'Lucy'})}
       title="Go to Lucy's profile"
       />
      </View>
    );
  }
}

class MyProfileScreen extends Component {
 render() {
   return (
     <View style={styles.container}>
       <Button
      onPress={() => this.props.navigation.goBack(null)}
      title="Go to Lucy's profile"
      />
     </View>
   );
 }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});


const ModalStack = StackNavigator({
  Home:{
    screen:MyHomeScreen,
    navigationOptions:({navigation}) => {
      return {
        title:'Home',
        // header:Header,
        // headerTitle:'tony tony'
        // headerBackTitle:'tony'
        headerRight:<Text>注册</Text>,
        headerLeft:<Text>登录</Text>,
        headerStyle:{paddingLeft:20,paddingRight:20},
        headerTitleStyle:{color:'#ffb300'},
        headerTintColor : 'red',
      }
    }
  },
  Profile:{
    screen:MyProfileScreen,
     // Optional: When deep linking or using react-navigation in a web app, this path is used
     path:'people/:name',
     navigationOptions:({navigation})=>({
       title:`${navigation.state.params.name}'s profile'`,
       headerTintColor : 'red',
       gesturesEnabled:false,
     }),
   }
},{
  //Defines the style for rendering and transitions
  mode:'card',
  headerMode:'float'
})
export default ModalStack
