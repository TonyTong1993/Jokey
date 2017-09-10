'use strict';

import React, { Component } from 'react';
import {
  StyleSheet,
  View,
  Text,
  FlatList,
  Image,
  Button,
} from 'react-native';
import ReCycleView from '../components/ShopHeader'
import SearchHeader from '../components/SearchHeader'
import ShopFooter from '../components/ShopFooter'
import RowBanner from '../components/RowBanner'
import ThirdBanner from '../components/ThirdBanner'
import {screen_width,screen_height} from '../Config'

const data = [
              {key:'http://img63.ddimg.cn/upload_img/00721/zjl/640x342_wzh_20170830.jpg'},
              {key:['图书','电子书','网络文学','当当优品','当当优品',
                    '童书','母婴','玩具','童装童鞋','创意文具',
                    '女装','男装','内衣配饰','鞋靴箱包','户外活动',
                    '美妆个护','食品','运营健康','珠宝手表','当当优选',
                    '家居家纺','家电','Apple','手机数码','图书榜']},
              {key:'商品---003'},
                  ]

class HomePage extends Component {
	static navigationOptions = ({navigation}) =>({
     header:()=>{
       return <SearchHeader headerCategoryClicked={()=>navigation.navigate('Search')}/>
     }
   })
 constructor(props){
    super(props)
    this.state = {
      pulling:false
    }
  }
  render() {
    return (
       <View style={styles.container}>
         <FlatList
           automaticallyAdjustContentInsets={false}
           contentContainerStyle={{paddingBottom:49,paddingTop:0}}
           data={data}
           ListHeaderComponent={ReCycleView}
           renderItem={this._renderItem}
           refreshing={this.state.pulling}
           onRefresh={this._loadNewData.bind(this)}
           onEndReached={()=>{
            console.log('onEndReached')
           }}
           onEndReachedThreshold={0.5}
         />
    
      </View>
    );
  }

  /*private method*/
  _renderItem(data:object) {
    switch (data.index) {
      case 0:
      return <View >
        <Image style={styles.firstBanner} source={{uri:data.item.key}}/>
      </View>
        break;
        case 1:
        return <RowBanner data={data.item.key}/>
          break;
        case 2:
        return <ThirdBanner />
            break;
        case 3:
        return <RowBanner />
            break;
        case 4:
        return <RowBanner />
            break;
      default:
      return <Text>'beyond bounds'</Text>
    }

  }
  _loadNewData(){
    this.setState({
      pulling:true
    });
     this.timer = setTimeout(()=>{
      this.setState({
      pulling:false
    });
      this.timer && clearTimeout(this.timer);
    },3000)
  }
_headrCategoryClicked = ()=>{
	this.props.navigation.navigate('Search')
}
}

const styles = StyleSheet.create({
 container:{
    flex:1,
    backgroundColor:'#fff'
  },
  textStyle:{
    textAlign:'center',
    backgroundColor:'#53e021'
  },
  firstBanner:{
    width:screen_width,
    height:200,
  },
  thirdBanner:{
    width:screen_width,
    height:50,
    backgroundColor:'#ffb300'
  }
});


export default HomePage;