'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Image,
  FlatList,
  Text
} from 'react-native';

class CGFruitPage extends Component {
  static navigationOptions = {
    drawerLabel: '美味水果',
    drawerIcon: ({ focused,tintColor }) => (
      focused ?
      <Image
        source={{uri:'drawer_fruit_selected'}}
        style={styles.icon}
      /> 
      :
      <Image
        source={{uri:'drawer_fruit_normal'}}
        style={styles.icon}
      />
    ),
  };
  render() {
    return (
      <View />
    );
  }
}

const styles = StyleSheet.create({
container: {
    flex: 1,
    justifyContent:'center',
    alignItems:'center',
  },
  icon:{
    width:24,
    height:24,
    resizeMode:'center',
  }
});


export default CGFruitPage;