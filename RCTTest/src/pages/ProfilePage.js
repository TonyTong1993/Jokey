'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Text,
  FlatList
} from 'react-native';
const data = [{key:'测试数据-001'},{key:'测试数据-002'},{key:'测试数据-003'},{key:'测试数据-004'}]
class ProfilePage extends Component {
  constructor(props) {
    super(props);
    this.state = {

    };
  }
  render() {
    return (
     <View style={styles.container}>
      	 <FlatList data={data} renderItem={({item})=><Text>{item.key}</Text>}/>
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


export default ProfilePage;
