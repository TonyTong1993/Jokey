import React from 'react';
import goods from '../components/Fruits.json'
import {
	View,
} from 'react-native';
import {
	screen_width,
	onePixel
} from '../Config'
const SeparatorComponent = () => {
	return (
		<View style={{width:screen_width,height:onePixel,backgroundColor:'#ebebeb'}}/>
	)
}
module.exports = SeparatorComponent;