'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Image,
  Text,
} from 'react-native';

import { screen_width } from '../../Config.js'

class CategoryHeader extends Component {
  render() {
    return (
      <View style={styles.contianer}>
      	<View style={styles.searchView}>
      		<Image style={styles.icon} source={require('../../imgs/search-btn.png')}/>
      		<Text>搜索内容</Text>
      	</View>
      	<View style={{width:32,height:32,justifyContent:'center'}}>
      	<Image style={styles.qrCode} source={require('../../imgs/qrcode.png')}/>
      	<Text style={{fontSize:8}}>扫一扫</Text>
      	</View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
	contianer:{
		marginTop:20,
		width:screen_width,
		height: 44,
		backgroundColor: '#fff',
		paddingLeft:10,
		paddingRight:10,
		flexDirection:'row',
		alignItems:'center',
		backgroundColor:'#fff'
	},
	searchView:{
		flex:1,
	    alignItems:'center',
	    height:30,
	    paddingLeft:7.5,
	    paddingRight:7.5,
	    backgroundColor:'#E8EBF0',
	    borderRadius:15,
	    flexDirection:'row',
	    marginRight: 10,
	  },
	icon:{
	    width:27,
	    height:27,
	    alignSelf: 'center' ,
	    tintColor:'#81888E',
	    resizeMode :'center',
  },
  qrCode:{
  	 width:24,
	 height:24,
	 tintColor:'#81888E',
	 resizeMode :'center'
  }
});


export default CategoryHeader;