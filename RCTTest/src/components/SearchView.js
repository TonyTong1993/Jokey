import React, {PropTypes} from 'react';
import {
  StyleSheet,
  View,
  Text,
  TextInput,
  Dimensions,
  Image,
} from 'react-native'
import screen_width from '../Config'
export default class SearchView extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View style={styles.container}>
         <Image style={styles.icon} source={require('../imgs/search-btn.png')} resizeMode='center'/>
         <View style={styles.textContainer}>
             <Text style={styles.text}>开学大促每满200减100</Text>
         </View>
          <Image style={styles.icon} source={require('../imgs/bar-code-scan.png')} resizeMode='center'/>
      </View>
    );
  }
}

SearchView.propTypes = {
};

var styles = StyleSheet.create({
  container:{
    justifyContent:'space-between',
    alignItems:'center',
    width:screen_width-89,
    height:30,
    paddingLeft:7.5,
    paddingRight:7.5,
    backgroundColor:'#E8EBF0',
    borderRadius:15,
    flexDirection:'row'
  },
  icon:{
    width:27,
    height:27,
    tintColor:'#81888E',
  },
  textContainer:{
    flex:1,
    height:30,
    justifyContent:'center',
  },
  text:{
    fontSize:11,
    color:'#A1A7AE',
    textAlign:'left'
  }
})
