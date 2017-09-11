'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Text,
} from 'react-native';

class CartPage extends Component {
  render() {
    return (
      <View style={styles.container}>
      	<Text> this is Cart Page</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
	container:{
		flex:1,
		justifyContent:'center',
		alignItems:'center',
	}
});


export default CartPage;