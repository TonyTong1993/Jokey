'use strict';

import React, {
	Component
} from 'react';

import {
	StyleSheet,
	View,
	Image,
	Text,
	TouchableOpacity
} from 'react-native';
import {
	screen_width,
} from '../Config'
class FruitCell extends Component {

	render() {
		return ( 
		    <TouchableOpacity onPress = {this.props.onPress} >
			    <View style={styles.container}>
				      	<Image style={styles.cover} source={{uri:this.props.data.cover}}>
				      	<Text style={styles.textStyle}>{this.props.data.title}</Text>
				      	</Image>
		        </View>
		      </TouchableOpacity>
		);
	}
}

const styles = StyleSheet.create({
	container: {
		alignItems: 'center',
		padding: 10,
	},
	cover: {
		width: (screen_width - 50) / 2,
		height: ((screen_width - 50) / 2) / 1.384,
		alignItems: 'center',
		justifyContent: 'flex-end'
	},
	textStyle: {
		textAlign: 'center',
		backgroundColor: 'transparent'
	}
});


export default FruitCell;