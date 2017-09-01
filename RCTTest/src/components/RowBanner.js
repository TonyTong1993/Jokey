/* @flow */

import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
} from 'react-native';
import {screen_width,onePixel} from '../Config'
const data = ['图书','电子书','网络文学','当当优品','文玩拍卖']
export default class RowBanner extends Component {
  render() {
    const nodes = data.map((data,index)=>{
      return this._renderItem(data,index)
    })
    return (
      <View style={styles.container}>
        {nodes}
      </View>
    );
  }
  _renderItem(data:string,index:number) {
    return (
      <View key={index} style={styles.item}>
         <View style={styles.textContainer} >
        <Text style={styles.textStyle}>{data}</Text>
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
    alignItems:'center',
    flexDirection:'row',
    paddingRight:1,
  },
 textContainer:{
   alignSelf:'center',
   flexDirection:'row',
   borderRightWidth:onePixel,
   borderRightColor:'#ebebeb'
 },
  textStyle:{
    flex:1,
    fontSize:12.3,
    textAlign:'center',
    color:'#000000',
  }
});
