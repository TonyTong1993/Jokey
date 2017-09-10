'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Text,
} from 'react-native';
import CategoryHeader from '../components/categoryComponents/CategoryHeader.js'
import CategoryNavigator from '../DrawerRoutesConfig.js'

class CategoryPage extends Component {
  static navigationOptions = ({navigation}) =>({
     header:()=>{
       return <CategoryHeader />
     }
   })
  render() {
    return (
        <CategoryNavigator />
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


export default CategoryPage;