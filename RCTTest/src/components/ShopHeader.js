import React from 'react'
import {
  StyleSheet,
  View,
  Image,
  ScrollView,
  Text,
  Dimensions
} from 'react-native';
const width = Dimensions.get('window').width;
const data = [
              "http://img61.ddimg.cn/upload_img/00705/yhj4/640x284_lyx_0829.jpg",
              "http://img63.ddimg.cn/upload_img/00657/830/Touch-6.6-1.jpg",
              "http://img54.ddimg.cn/192030035267244_y.jpg"
            ];
export default class ReCycleView extends React.Component{

  constructor(props) {
    super(props);
    this.state = {
      page:0
    }
  }
  componentDidMount(){
    //开启计时器
    var scrollView = this.refs.scrollView

    this.timer = setInterval(()=>{
      var activePage = this.state.page+1;

      this.setState({
        page:activePage%3
      })
       scrollView.scrollResponderScrollTo({x:this.state.page*width,y:0,animated:true})
    },5000)

  }
  componentWillUnmount() {
     this.timer && clearInterval(this.timer);
  }
    render() {

      return (
        <ScrollView
          ref='scrollView'
          contentContainerStyle={styles.container}
          horizontal={true}
          pagingEnabled={true}
          showsHorizontalScrollIndicator={false}
          automaticallyAdjustContentInsets={false}
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
    height:166.41,//fixme:需做尺寸适配
    backgroundColor:'#ffb300',
    justifyContent:'center',
    alignItems:'center'
  },
  RecycleImage:{
    width:Dimensions.get('window').width,
    height:166.41
  }
})
