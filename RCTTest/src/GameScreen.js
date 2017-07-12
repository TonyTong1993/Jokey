'use strict';

import React, { Component } from 'react';
import {
  StyleSheet,
  View,
  Text,
  TouchableHighlight,
} from 'react-native';

import * as API from './service/common_api';
import Icon from 'react-native-vector-icons/FontAwesome';
const myIcon = (<Icon name="rocket" size={30} color="#900" />)
class GameScreen extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.hello}>Hello, My Hybrid App!</Text>
        <Text style={styles.hello}>{this.props.content}</Text>
        <TouchableHighlight onPress={this.props.onClick} >
        	<Text style={styles.hello}>{myIcon} </Text>
        </TouchableHighlight>

      </View>
    );
  }
  componentDidMount() {
 
}
}
const styles = StyleSheet.create({
 container: {
    flex: 1,
    justifyContent: 'center',
  },
  hello: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
});


export default GameScreen;