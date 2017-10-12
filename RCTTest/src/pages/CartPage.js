'use strict';

import React, { Component } from 'react';
/*学习测试文件头*/
import SimpleAnimationView from './../test-pages/react-animation-class/Animation-01'
import {
  StyleSheet,
  View,
  Text,
} from 'react-native';

class CartPage extends Component {
  render() {
    return (
      <View style={styles.container}>
        <SimpleAnimationView>
          <Text> this is Cart Page</Text>
        </SimpleAnimationView>
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
