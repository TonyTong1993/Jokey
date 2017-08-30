import React from 'react';
import {
  StyleSheet,
  NavigatorIOS,
  TabBarIOS,
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import ShopPage from './pages/ShopPage';

const home = (
   <NavigatorIOS
            initialRoute={{
              component:ShopPage,
              title:'乐跑商城'
            }}
           style={{flex:1}}/>
)
const category = (
   <NavigatorIOS
            initialRoute={{
              component:ShopPage,
              title:'分类'
            }}
           style={{flex:1}}/>
)
const discover = (
   <NavigatorIOS
            initialRoute={{
              component:ShopPage,
              title:'发现'
            }}
          style={{flex:1}}/>
)
const cart = (
   <NavigatorIOS
            initialRoute={{
              component:ShopPage,
              title:'购物车'
            }}
           style={{flex:1}}/>
)
const home_normal_icon = (<Icon name='home' size={20} color='#d3d3d3'/>)
const home_selected_icon = (<Icon name='home' size={20} color='#0bad61'/>)

const category_normal_icon = (<Icon name='fa-object-group' size={20} color='#d3d3d3'/>)
const category_selected_icon = (<Icon name='fa-object-group' size={20} color='#0bad61'/>)

const discover_normal_icon = (<Icon name='search' size={20} color='#d3d3d3'/>)
const discover_selected_icon = (<Icon name='search' size={20} color='#0bad61'/>)

const cart_normal_icon = (<Icon name='fa-shopping-cart' size={20} color='#d3d3d3'/>)
const cart_selected_icon = (<Icon name='fa-shopping-cart' size={20} color='#0bad61'/>)
export default class App extends React.Component {


  render() {
        return  (
          <TabBarIOS tintColor='#0bad61'>
             <Icon.TabBarItem
               renderAsOriginal= {true}
               title='首页'
               selected={true}
               iconSize={22}
               iconName='search'>
               {home}
             </Icon.TabBarItem>
             <Icon.TabBarItem
               title='分类'>
               <ShopPage />
             </Icon.TabBarItem>
             <Icon.TabBarItem
               title='发现'>
                <ShopPage />
             </Icon.TabBarItem>
             <Icon.TabBarItem
               title='购物车'>
               <ShopPage />
             </Icon.TabBarItem>
          </TabBarIOS>
      );
  }
}

var styles = StyleSheet.create({
  container: {
    flex:1,
  }
})
