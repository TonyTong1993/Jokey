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
import screen_width from '../Config'
import SearchView from './SearchView'
export default class SearchHeader extends React.Component {
  constructor(props) {
    super(props);
    this.state = { text: 'Useless Placeholder' };
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity >
          <Image style={styles.leftIcon} source={require('../imgs/white_header-category.png')} resizeMode='center'/>
        </TouchableOpacity>
        <TouchableOpacity>
          <SearchView />
        </TouchableOpacity>
        <TouchableOpacity >
          <Image style={styles.rightIcon} source={require('../imgs/message.png')} resizeMode='center'/>
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
      marginTop:20,
      height:44,
      flexDirection:'row',
      alignItems:'center'
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
