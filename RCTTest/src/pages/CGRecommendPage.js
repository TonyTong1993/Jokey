'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Text,
  Image,
  SectionList,
  FlatList,
} from 'react-native';
import categories from '../category.json'
import CGRItemCell from '../components/categoryComponents/CGRItemCell.js'
import { screen_width } from '../Config.js'
const group = categories.show_1st[0].pile[0].group;
const sections =[
					{
						data:group[0].detail,
						key:group[0].group_name
					},{
						data:group[1].detail,
						key:group[1].group_name
					}];
class CGRecommendPage extends Component {
	static navigationOptions = {
    drawerLabel: '推荐内容',
     drawerIcon: ({ focused,tintColor }) => (
    	focused ?
      <Image
        source={{uri:'drawer_recommend_selected'}}
        style={styles.icon}
      />
      :
      <Image
        source={{uri:'drawer_recommend_normal'}}
        style={styles.icon}
      />
    ),
  };

_keyExtractor = (item,index)=>{
	return `category-${index}`
};

  render() {
    return (
       <View style={styles.container}>
      	  <SectionList
      	  		keyExtractor={this._keyExtractor}
      	  		renderSectionHeader={({section})=>
      	  		<View
      	  		style={{width:screen_width,height:28,justifyContent:'center'}}>
	      	  		<Text>{section.key}</Text>
      	  		</View>}
      	  		sections={sections}
              renderItem={({item})=><CGRItemCell item={item} />}
      	  	  contentContainerStyle={styles.list}
              removeClippedSubviews = {false}
      	  />
       </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  icon:{
  	width:24,
  	height:24,
  	resizeMode:'center',
  },
  list: {
        //justifyContent: 'space-around',
        flexDirection: 'row',//设置横向布局
        flexWrap: 'wrap',  //设置换行显示
        alignItems: 'flex-start',
        backgroundColor: '#FFFFFF'
    },
});


export default CGRecommendPage;
