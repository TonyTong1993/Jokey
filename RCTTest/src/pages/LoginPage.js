'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Text,
  TextInput,
  TouchableOpacity
} from 'react-native';

import { connect } from 'react-redux';

import { onePixel } from '../Config'
class LoginPage extends Component {
  render() {
    return (
      <View style={styles.container}>
      	<TextInput 
      		style = {styles.input}
	      	autoCorrect={false} 
	      	maxLength={12} 
	      	placeholder='请输入用户名'
	      	placeholderTextColor ='#999'/>

	      	<TextInput 
	      	style = {styles.input}
	      	autoCorrect={false} 
	      	maxLength={12} 
	      	placeholder='请输入密码'
	      	placeholderTextColor ='#999'
	      	secureTextEntry={true}/>
	    <TouchableOpacity onPress={this._login}> 
	      	<View style={styles.enter}> 
	      		<Text>登录</Text>
	      	</View>
	    </TouchableOpacity>
	    <Text>{this.props.movies.payload.description}</Text>  	
      </View>
    );
  }
  /* 发起GET网络请求方法
  _login = (url:string,params:object) => {
  	 fetch('https://facebook.github.io/react-native/movies.json')
      .then((response) => response.json())
      .then((responseJson) => {
	    console.log (responseJson.movies)
      })
      .catch((error) => {
        console.error(error);
      });
  }

  async getMoviesFromApi() {
    try {
      // 注意这里的await语句，其所在的函数必须有async关键字声明
      let response = await fetch('https://facebook.github.io/react-native/movies.json');
      let responseJson = await response.json();
      console.log(responseJson.movies);
    } catch(error) {
      console.error(error);
    }
  }
  */
}

const styles = StyleSheet.create({
	container:{
		flex:1, 
	},
	input:{
		alignSelf: 'center',
		width:200,
		height: 36,
		borderWidth: onePixel,
		borderColor: '#000000',
		marginBottom: 20
	},
	enter:{
		alignSelf:'center',
		width:200,
		height:36,
		borderRadius: 18,
		backgroundColor: '#51a32d',
		justifyContent: 'center',
		alignItems: 'center'
	}
});

const mapStateToProps = (state)=>{
	return {
		movies:state
	}
}
export default connect(mapStateToProps)(LoginPage);