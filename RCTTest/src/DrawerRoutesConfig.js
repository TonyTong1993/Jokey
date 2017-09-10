'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Image,
  Text,
} from 'react-native';

import { DrawerNavigator } from 'react-navigation'
import { screen_width } from './Config.js'
import CGRecommendPage from './pages/CGRecommendPage.js'
import CGBookPage from './pages/CGBookPage.js'
import CGFruitPage from './pages/CGFruitPage.js'
import { themeColor } from './theme.js'
const CategoryNavigator = DrawerNavigator({
	Recommend:{
		screen:CGRecommendPage
	},
	Book:{
		screen:CGBookPage
	},
	Fruit:{
		screen:CGFruitPage
	}
},{
	drawerWidth:screen_width*0.618,
	drawerPosition:'right',
	contentOptions:{
		activeTintColor:themeColor,
	}
})

export default CategoryNavigator