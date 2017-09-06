import React from 'react';
import {
  StyleSheet,
  Navigator,
  NavigatorIOS,
  Image,
  View,
  Text
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import TabNavigator from 'react-native-tab-navigator'
import ShopPage from './pages/ShopPage';
import FruitShopPage from './pages/FruitShopPage';
import FruitDetialPage from './pages/FruitDetialPage';
import DetailPage from './pages/DetailPage';
import LoginPage from './pages/LoginPage';
import SearchHeader from './components/SearchHeader'
const homeRouteStack = [
              {
                component:ShopPage,
                name:'home',
                index:0
              },{
                component:DetailPage,
                name:'detail',
                index:1
              }
]
const navigationBar = (
    <SearchHeader />
)
const home = (
   <Navigator
            initialRoute={homeRouteStack[0]}
            renderScene = {(route,navigator)=>{
              let Component = route.component;
              return <Component {...route.params} navigator= {navigator} />
            }}
            initialRouteStack = {homeRouteStack}

          />
)
const category = (
   <Navigator
            initialRoute={{
              name:'category',
              index:0,
              component:FruitShopPage
            }}
            navigationBar = {navigationBar}
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
       selectedTitleStyle={styles.theme}
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
             {this._renderTabItem('category',require('./imgs/tab/category_off@3x.png'),require('./imgs/tab/category_on@3x.png'),category)}
             {this._renderTabItem('discover',require('./imgs/tab/discover_off@3x.png'),require('./imgs/tab/discover_on@3x.png'),discover)}
             {this._renderTabItem('cart',require('./imgs/tab/cart_off@3x.png'),require('./imgs/tab/cart_on@3x.png'),cart)}
          </TabNavigator>
      );
  }
}

var styles = StyleSheet.create({
  container: {
    flex:1,
  },
  theme:{
    color:'#0bad61'
  }
})
