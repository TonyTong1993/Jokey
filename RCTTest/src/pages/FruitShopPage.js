'use strict';

import React, {
	Component
} from 'react';
import goods from '../components/Fruits.json'
import {
	StyleSheet,
	View,
	FlatList,
	Text,
	AsyncStorage
} from 'react-native';
import FruitCell from '../components/FruitCell'

class FruitShopPage extends Component {
	constructor(props) {
	  super(props);
	}
	
 _onPressItem = ()=> {
		alert('hello world')
	}
	render() {
		return (
			<View style={{flex:1,backgroundColor:'#f5f5f5'}}>
			<FlatList data = {
				goods.data
			}

			contentContainerStyle={{
									alignItems:'center'
								}}
			numColumns={2}
			renderItem = {
				this._renderItem
			}
			/>
			</View>
		);
	}
	componentDidMount() {
		//保存
		// AsyncStorage.setItem("fruits", JSON.stringify(goods), (error) => {
		// 	if (error) {
		// 		alert('保存失败')
		// 		return
		// 	}
		// 	alert('保存成功')
		// })
		//读取
		// AsyncStorage.getItem('fruits', (error, result) => {
		// 	if (error) {
		// 		alert('取数据失败')
		// 		return
		// 	}

		// 	alert(JSON.parse(result).data)
		// })
	}
	_renderItem = ({item}) =>{
		return (
			<FruitCell 
				id={item.key}
				data={item}
				onPress = {this._onPressItem}
			/>
		)
	}
	
}

const styles = StyleSheet.create({

});


export default FruitShopPage;