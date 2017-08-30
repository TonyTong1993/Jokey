import React from 'react';
import {
  StyleSheet,
  NavigatorIOS,
  TabBarIOS,
  View,
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import ShopPage from './pages/ShopPage';

const home = ()=>{
  return <NavigatorIOS
            initialRote={{
              components:ShopPage,
              title:'乐跑商城'
            }}
           style={styles.container}/>
};
const category = ()=>{
  return <NavigatorIOS
            initialRote={{
              components:ShopPage,
              title:'分类'
            }}
           style={styles.container}/>
};
const discover = ()=>{
  return <NavigatorIOS
            initialRote={{
              components:ShopPage,
              title:'发现'
            }}
           style={styles.container}/>
};
const cart = ()=>{
  return <NavigatorIOS
            initialRote={{
              components:ShopPage,
              title:'购物车'
            }}
           style={styles.container}/>
};
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
          <TabBarIOS >
             <TabBarIOS.Item
               title='首页'
               selected={true}>
               (<View style={{backgroundColor: '#ffffff'}}>
      </View>)
             </TabBarIOS.Item>

          </TabBarIOS>
      );
  }
}

var styles = StyleSheet.create({
  container: {
    flex:1,
  }

})
