/* @flow */

import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
} from 'react-native';
import screen_width from '../Config'
export default class RowBanner extends Component {
  render() {
    return (
      <View style={styles.container}>
        <View style={styles.item}>
          <Text style={styles.textStyle}>图书</Text>
        </View>
        <View style={styles.item}>
          <Text style={styles.textStyle}>电子书</Text>
        </View>
        <View style={styles.item}>
          <Text style={styles.textStyle}>网络文学</Text>
        </View>
        <View style={styles.item}>
          <Text style={styles.textStyle} >当当优品</Text>
        </View>
        <View style={styles.item}>
          <Text style={styles.textStyle}>文玩拍卖</Text>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    width:screen_width,
    height:40,
    flexDirection:'row',
  },
  item:{
    flex:1,

    justifyContent:'center',
    alignItems:'center'
  },
  textStyle:{
    fontSize:12.3,
    color:'#000000',
  }
});
