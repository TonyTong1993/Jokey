'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Image,
  SectionList,
  Text
} from 'react-native';
import { screen_width } from '../Config'
const sections = [
  {data:['安倍','安顺','安心','安全','安庆'],key:'an'},
  {data:['编辑','编码','编织','编剧','编排'],key:'bian'},
  {data:['长江','长城','长春','长安','长年'],key:'chang'}
]
class CGFruitPage extends Component {
  static navigationOptions = {
    drawerLabel: '美味水果',
    drawerIcon: ({ focused,tintColor }) => (
      focused ?
      <Image
        source={{uri:'drawer_fruit_selected'}}
        style={styles.icon}
      />
      :
      <Image
        source={{uri:'drawer_fruit_normal'}}
        style={styles.icon}
      />
    ),
  };
  _renderItem = ({item}) => {
    return <View
      style={{width:(screen_width-60)/5,height:32,alignItems:'center',justifyContent:'center',borderColor:'#505050',borderWidth:1,marginRight:10}}>
      <Text>{item}</Text>
    </View>
  }
  _renderSectionHeader = ({section})=>{
    return <View style={{width:screen_width,height:32,alignItems:'center'}}>
        <Text>{section.key}</Text>
    </View>
  }
  _keyExtractor = (item,index)=>{
    return `xxx-${index}`
  }
  _ItemSeparatorComponent = ()=>{
    return <View style={{width:screen_width,height:1,backgroundColor:'#ffb300'}}/>
  }
  render() {
    console.log('CGFruitPage--componentDidMount');
    return (
      <View style={styles.container}>
        <SectionList
          renderItem={this._renderItem}
          renderSectionHeader = {this._renderSectionHeader}
          // ItemSeparatorComponent = {this._ItemSeparatorComponent}
          sections = {sections}
          keyExtractor={this._keyExtractor}
          contentContainerStyle = {{
            flexWrap:'wrap',
            flexDirection:'row',
            alignItems: 'flex-start',
            paddingLeft:10,
            paddingTop:20,
          }}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
container: {
    flex: 1,
    justifyContent:'center',
    alignItems:'center',
  },
  icon:{
    width:24,
    height:24,
    resizeMode:'center',
  }
});


export default CGFruitPage;
