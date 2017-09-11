'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Image,
  Text,
} from 'react-native';
import { screen_width,onePiexl } from '../../Config.js'
class CGRItemCell extends Component {
  render() { 
  	const nodes = (this.props.item.icon != '-1') ? 
  	 <View style={styles.container}>
           <Image style={styles.cover} source={{uri:this.props.item.icon}}/>
           <Text style={styles.textStyle}>
      		{this.props.item.title}
      	   </Text>
      </View>
      : 
      (
      	<View style={styles.textContainer}>
          <Text style={styles.textStyle}>
      		{this.props.item.title}
      	  </Text>
      </View>
      	)
    return nodes;
    
  }

}

const styles = StyleSheet.create({
	container:{
		width:screen_width/4,
		height:screen_width/4 + 34,
		alignItems:'center'
	},
	textContainer:{
		width:screen_width/4,
		height:34,
		alignItems:'center',
		borderWidth: onePiexl,
		borderColor:'#ebebeb'
	},
	cover:{
		width:80,
		height:80,
		resizeMode:'center',
	},
	textStyle:{
		marginTop: 10,
		fontSize:12,
		color:'#333'
	}
});


export default CGRItemCell;