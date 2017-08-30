import React from 'react'
import {
  StyleSheet,
  NavigatorIOS
} from 'react-native'
import ShopPage from './pages/ShopPage'
export default class App extends React.Component {

  render() {
        return  (
        <NavigatorIOS
          initialRoute={{
            component:ShopPage,
            title:'乐跑商城'
          }}
          style={styles.container}
        />
      );
  }
}

var styles = StyleSheet.create({
  container: {
    flex:1,
  }
})
