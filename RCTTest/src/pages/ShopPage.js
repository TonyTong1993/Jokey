import React from 'react'
import {
  StyleSheet,
  View,
  Text,
  FlatList,
  Image,
} from 'react-native'
import ReCycleView from '../components/ShopHeader'
import SearchHeader from '../components/SearchHeader'
import RowBanner from '../components/RowBanner'
import {screen_width} from '../Config'
export default class ShopPage extends React.Component {

  render() {
    return (
      <View style={styles.container}>
         <SearchHeader />
         <FlatList
           automaticallyAdjustContentInsets = {false}
           contentContainerStyle={{flex:1}}
           data={[{key:'商品----01'},{key:'商品----02'},{key:'商品----03'},{key:'商品----04'},{key:'商品----05'}]}
           ListHeaderComponent={ReCycleView}
           renderItem={this._renderItem}
         />
      </View>

    );
  }
  _renderItem(data:object) {
    switch (data.index) {
      case 0:
      return <View >
        <Image style={styles.firstBanner} source={{uri:'http://img63.ddimg.cn/upload_img/00721/zjl/640x342_wzh_20170830.jpg'}}/>
      </View>
        break;
        case 1:
        return <RowBanner />
          break;
        case 2:
        return <RowBanner />
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
}

var styles = StyleSheet.create({
  container:{
    flex:1,
  },
  textStyle:{
    textAlign:'center',
    backgroundColor:'#53e021'
  },
  firstBanner:{
    width:screen_width,
    height:200,
  }
})
