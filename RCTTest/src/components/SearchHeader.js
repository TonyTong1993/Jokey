import React, {PropTypes} from 'react';
import {
  StyleSheet,
  View,
  Image,
  TouchableOpacity,
}
import Config from '../Config'
export default class SearchHeader extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View >
        <TouchableOpacity >
          <Image style={styles.leftIcon} source={{uri:''}/>
        </TouchableOpacity>
        <TouchableOpacity>
          <SearchView />
        </TouchableOpacity>
        <TouchableOpacity >
          <Image style={styles.rightIcon} source={{uri:''}}/>
        </TouchableOpacity>
      </View>
    );
  }
}

SearchHeader.propTypes = {
};
var styles = StyleSheet.create({
    container:{
      flex:1,
      height:44,
    },
    leftIcon:{
      width:40,
      height:44,
    },
    rightIcon:{
      width:49,
      height:44,
    }
})
