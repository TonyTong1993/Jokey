import React from 'react'
import {
  StyleSheet,
  View,
  Image,
  ScrollView,
  Text,
  Dimensions
} from 'react-native';
import Swiper from 'react-native-swiper'
const width = Dimensions.get('window').width;
const data = [
              "http://img61.ddimg.cn/upload_img/00705/yhj4/640x284_lyx_0829.jpg",
              "http://img63.ddimg.cn/upload_img/00657/830/Touch-6.6-1.jpg",
              "http://img54.ddimg.cn/192030035267244_y.jpg"
            ];
export default class ReCycleView extends React.Component{

    render() {
      const nodes = data.map((imgUrl,index)=>{
        return this._renderSlider(imgUrl,index)
      })
      return (
        <View
          style={styles.container}>
            <Swiper
              height={166.4}
              index={0}
              autoplay={true}
              horizontal={true}>
               {nodes}
            </Swiper>
        </View>
      )
    }
    _renderSlider(data:string,index:number) {
      return (
         <Image
         key={index}
         style={styles.slide}
         source={{uri:data}}/>
        );
    }
}

var styles = StyleSheet.create({
  container: {
    width:width,
    height:166.4,//fixme:需做尺寸适配
  },
  slide:{
    width:width,
    height:166.4,
  }
})
