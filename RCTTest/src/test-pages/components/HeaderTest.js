/* @flow */

import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
} from 'react-native';
import { screen_width } from '../../Config'
export default class HeaderTest extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>I'm the HeaderTest component</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    width: screen_width,
    height:36,
  },
});
