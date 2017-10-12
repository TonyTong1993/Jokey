/* @flow */

import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Animated,
} from 'react-native';

export default class SimpleAnimationView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      fadeAnim:new Animated.Value(0)
    }
  }
  render() {
    return (
      <Animated.View          // Special animatable View
        style={[styles.container,{
          opacity: this.state.fadeAnim,
          transform: [{
       translateY: this.state.fadeAnim.interpolate({
         inputRange: [0, 1],
         outputRange: [150, 0]  // 0 : 150, 0.5 : 75, 1 : 0
       }),
     }],}]}>
        {this.props.children}
      </Animated.View>
    );
  }
  componentDidMount() {
    Animated.timing(
      this.state.fadeAnim,
      {toValue:1},
    ).start()
  }
}

const styles = StyleSheet.create({
  container: {
    width:100,
    height:100,
    backgroundColor:'red',
  },
});
