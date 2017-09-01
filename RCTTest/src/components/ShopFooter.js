/* @flow */

import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
} from 'react-native';
import {screen_width,screen_height} from '../Config'
export default class ShopFooter extends Component {
  render() {
    return (
      <View style={styles.container}>

      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    width: screen_width,
    height:49,
    backgroundColor:'#ffb300'
  },
});
