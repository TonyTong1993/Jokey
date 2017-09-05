import React from 'react';
import {
  StyleSheet,
  NavigatorIOS,
  Image,
  View,
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import TabNavigator from 'react-native-tab-navigator'
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
export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedTab:'Home'
    }
  }

  render() {
        return  (
          <TabNavigator>
             <TabNavigator.Item
               title='首页'
               renderIcon={()=> <Image source={require('./imgs/tab/home_off@3x.png')}/>}
               renderSelectedIcon={()=> <Image source={require('./imgs/tab/home_on@3x.png')}/>}
               selected={this.state.selectedTab === 'Home'}
               onPress={()=>this.setState({
                 selectedTab:'Home'
               })}>
                {<ShopPage />}
             </TabNavigator.Item>
             <TabNavigator.Item
               title='分类'
               renderIcon={()=> <Image source={require('./imgs/tab/discover_off@3x.png')}/>}
               renderSelectedIcon={()=> <Image source={require('./imgs/tab/discover_on@3x.png')}/>}
               selected={this.state.selectedTab === 'Category'}
               onPress={()=>this.setState({
                 selectedTab:'Category'
               })}>
                {<FruitShopPage />}
             </TabNavigator.Item>
             <TabNavigator.Item
               title='发现'
               renderIcon={()=> <Image source={require('./imgs/tab/lepao_off@3x.png')}/>}
               renderSelectedIcon={()=> <Image source={require('./imgs/tab/lepao_on@3x.png')}/>}
               selected={this.state.selectedTab === 'Discover'}
               onPress={()=>this.setState({
                 selectedTab:'Discover'
               })}>
                {<LoginPage />}
             </TabNavigator.Item>
             <TabNavigator.Item
               title='购物车'
               renderIcon={()=> <Image source={require('./imgs/tab/user_off@3x.png')}/>}
               renderSelectedIcon={()=> <Image source={require('./imgs/tab/user_on@3x.png')}/>}
               selected={this.state.selectedTab === 'Cart'}
               onPress={()=>this.setState({
                 selectedTab:'Cart'
               })}>
                {<View />}
             </TabNavigator.Item>
          </TabNavigator>
      );
  }
}

var styles = StyleSheet.create({
  container: {
    flex:1,
  }
})
