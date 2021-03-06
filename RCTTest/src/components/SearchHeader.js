import React, {PropTypes} from 'react';
import {
  StyleSheet,
  View,
  Image,
  TouchableOpacity,
  Text,
  TextInput,
  Dimensions,
} from 'react-native'
import {screen_width,onePixel} from '../Config'
import SearchView from './SearchView'
export default class SearchHeader extends React.Component {
  constructor(props) {
    super(props);
    this.state = { text: 'Useless Placeholder' };
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress = {this.props.headerCategoryClicked}>
          <Image style={styles.leftIcon} source={{uri:'white_header-category.png'}} resizeMode='center'/>
        </TouchableOpacity>
        <TouchableOpacity onPress = {this.props.headerSearchClicked}>
          <SearchView />
        </TouchableOpacity>
        <TouchableOpacity onPress = {this.props.headerMessageClicked}>
          <Image style={styles.rightIcon} source={{uri:'message.png'}} resizeMode='center'/>
        </TouchableOpacity>

      </View>
    );
  }
}

SearchHeader.propTypes = {
};
var styles = StyleSheet.create({
    container:{
      width:screen_width,
      height:64,
      paddingTop:20,
      flexDirection:'row',
      alignItems:'center',
      borderBottomWidth:onePixel,
      borderBottomColor:'#e0e0e0',
      backgroundColor:'#fff'
    },
    leftIcon:{
      width:40,
      height:44,
      tintColor:'#81888E'
    },
    rightIcon:{
      width:49,
      height:44,
      tintColor:'#81888E'
    }

})
