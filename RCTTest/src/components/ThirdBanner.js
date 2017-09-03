'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Image,
  Text,
} from 'react-native';
class ThirdBanner extends Component {
  render() {
    return (
      <View style={styles.container}>
      	<Image style={styles.image} source={{uri:'http://img60.ddimg.cn/upload_img/00709/789065/123.png'}}/>
      	<View style={{flex:1}}>
      		<Text style={{fontSize:15.75,color:'#3c3c3c'}}>百万好书，满200减100</Text>
      	</View>
      		<Text style={{fontSize:13.5,color:'#999999'}}>更多</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
   container:{
   	flex:1,
   	height:50,
   	flexDirection:'row',
   	alignItems:'center',
   	paddingRight:10,
   	paddingLeft:10,
   	justifyContent:'space-between'
   },
   image:{
   	width:94,
   	height:49
   }
});


export default ThirdBanner;