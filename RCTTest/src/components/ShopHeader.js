import React from 'react'
import {
  StyleSheet,
  View,
  Image,
  ScrollView,
  Text,
  Dimensions
} from 'react-native'
const data = [
              "http://img61.ddimg.cn/upload_img/00705/yhj4/640x284_lyx_0829.jpg",
              "http://img63.ddimg.cn/upload_img/00657/830/Touch-6.6-1.jpg",
              "http://img54.ddimg.cn/192030035267244_y.jpg"
            ]
export default class ReCycleView extends React.Component{
    render() {
      return (
        <ScrollView
          contentContainerStyle={styles.container}
          horizontal={true}
          pagingEnabled={true}
          showsHorizontalScrollIndicator={false}
          >
         <Image
           style={styles.RecycleImage}
          source={{uri:data[0]}} />
          <Image
            style={styles.RecycleImage}
           source={{uri:data[1]}} />
           <Image
             style={styles.RecycleImage}
            source={{uri:data[2]}} />
        </ScrollView>
      )
    }
}

var styles = StyleSheet.create({
  container: {
    width:Dimensions.get('window').width*3,
    height:166.41,
    backgroundColor:'#ffb300',
    justifyContent:'center',
    alignItems:'center'
  },
  RecycleImage:{
    width:Dimensions.get('window').width,
    height:166.41
  }
})
