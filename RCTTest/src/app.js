import React from 'react';
import {
  StyleSheet,
  Navigator,
  NavigatorIOS,
  Image,
  View,
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import TabNavigator from 'react-native-tab-navigator'
import ShopPage from './pages/ShopPage';
import FruitShopPage from './pages/FruitShopPage';
import FruitDetialPage from './pages/FruitDetialPage';
import LoginPage from './pages/LoginPage';
const home = (
   <Navigator
            initialRoute={{
              component:ShopPage,
              name:'home',
              index:0,
            }}
            renderScene = {(route,navigator)=>{
              let Component = route.component;
              return <Component {...route.params} navigator= {navigator} />
            }}
          />
)
const category = (
   <Navigator
            initialRoute={{
              name:'category',
              index:0,
              component:FruitShopPage
            }}
            renderScene = {(route,navigator)=>{
              let Component = route.component;
              return <Component {...route.params} navigator = {navigator} />
            }}
           />
)
const discover = (
   <Navigator
            initialRoute={{
              component:LoginPage,
              name:'discover',
              index:0
            }}
            renderScene = {(route,navigator)=>{
              let Component = route.component;
              return <Component {...route.params} navigator = {navigator} />
            }}
            />
)
const cart = (
   <Navigator
            initialRoute={{
              component:FruitShopPage,
              name:'cart',
              index:0
            }}
            renderScene = {(route,navigator)=>{
              let Component = route.component;
              return <Component {...route.params} navigator = {navigator} />
            }}
            />
)
export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedTab:'home'
    }
  }
 _renderTabItem = (title,renderIcon,renderSelectedIcon,component) => {
   return (
     <TabNavigator.Item
       title={title}
       renderIcon={()=> <Image source={renderIcon}/>}
       renderSelectedIcon={()=> <Image source={renderSelectedIcon}/>}
       selected={this.state.selectedTab === title}
       onPress={()=>this.setState({
         selectedTab:title
       })}>
        {component}
     </TabNavigator.Item>
   );
 }
  render() {
        return  (
          <TabNavigator>
             {this._renderTabItem('home',require('./imgs/tab/home_off@3x.png'),require('./imgs/tab/home_on@3x.png'),home)}
             {this._renderTabItem('category',require('./imgs/tab/lepao_off@3x.png'),require('./imgs/tab/lepao_on@3x.png'),category)}
             {this._renderTabItem('discover',require('./imgs/tab/discover_off@3x.png'),require('./imgs/tab/discover_on@3x.png'),discover)}
             {this._renderTabItem('cart',require('./imgs/tab/user_off@3x.png'),require('./imgs/tab/user_on@3x.png'),cart)}
          </TabNavigator>
      );
  }
}

var styles = StyleSheet.create({
  container: {
    flex:1,
  }
})
