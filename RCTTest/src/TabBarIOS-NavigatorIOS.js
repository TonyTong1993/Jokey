import React from 'react';
import {
  StyleSheet,
  NavigatorIOS,
  TabBarIOS,
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import ShopPage from './pages/ShopPage';
import FruitShopPage from './pages/FruitShopPage';
import LoginPage from './pages/LoginPage';
const home = (
   <NavigatorIOS
            initialRoute={{
              component:ShopPage,
              title:'乐跑商城',
            }}
           style={{flex:1}}
           navigationBarHidden={true}
           translucent={false}/>
)
const category = (
   <NavigatorIOS
            initialRoute={{
              component:FruitShopPage,
              title:'分类'
            }}
            navigationBarHidden={false}
            translucent={false}
           style={{flex:1}}/>
)
const discover = (
   <NavigatorIOS
            initialRoute={{
              component:LoginPage,
              title:'发现'
            }}
            translucent={false}
            style={{flex:1}}/>
)
const cart = (
   <NavigatorIOS
            initialRoute={{
              component:FruitShopPage,
              title:'购物车'
            }}
            translucent={false}
            style={{flex:1}}/>
)
/* @flow */
  class RootTabBar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedTab:'首页'
    }
  }
  render() {
    return (
      <TabBarIOS
        tintColor='#0bad61'
        translucent={false}
        barTintColor='#ffffff'>
         <Icon.TabBarItem
           renderAsOriginal= {true}
           title='首页'
           selected={this.state.selectedTab === '首页'}
           iconSize={20}
           iconName='home'
           iconColor = '#d3d3d3'
           selectedIconName='home'
           selectedIconColor='#0bad61'
           onPress={()=>{
             this.setState({
               selectedTab:'首页'
             })
           }}>
             {home}
         </Icon.TabBarItem>
         <Icon.TabBarItem
           title='分类'
           iconSize={20}
           iconName='glass'
           iconColor = '#d3d3d3'
           selectedIconName='glass'
           selectedIconColor='#0bad61'
           selected={this.state.selectedTab === '分类'}
           onPress={()=>{
             this.setState({
               selectedTab:'分类'
             })
           }}>
             {category}
         </Icon.TabBarItem>
         <Icon.TabBarItem
           title='发现'
           iconSize={20}
           iconName='search'
           iconColor = '#d3d3d3'
           selectedIconName='search'
           selectedIconColor='#0bad61'
           selected={this.state.selectedTab === '发现'}
           onPress={()=>{
             this.setState({
               selectedTab:'发现'
             })
           }}>

              {discover}
         </Icon.TabBarItem>
         <Icon.TabBarItem
           title='购物车'
           iconSize={20}
           iconName='user'
           iconColor = '#d3d3d3'
           selectedIconName='user'
           selectedIconColor='#0bad61'
           selected={this.state.selectedTab === '购物车'}
           onPress={()=>{
             this.setState({
               selectedTab:'购物车'
             })
           }}>
          {cart}
         </Icon.TabBarItem>
      </TabBarIOS>
    );
  }
}
export default class App extends React.Component {
  render() {
        return  (
          <RootTabBar />
      );
  }
}

var styles = StyleSheet.create({
  container: {
    flex:1,
  }
})
