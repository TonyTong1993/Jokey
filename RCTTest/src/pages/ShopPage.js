import React from 'react'
import {
  StyleSheet,
  View,
  Text,
  FlatList,
} from 'react-native'
import ReCycleView from '../components/ShopHeader'
import SearchHeader from '../components/SearchHeader'
// import swiper from './SwiperView'
export default class ShopPage extends React.Component {

  render() {
    return (
      <View style={styles.container}>
         <SearchHeader />
         <FlatList
           automaticallyAdjustContentInsets = {false}
           contentContainerStyle={{flex:1}}
           data={[{key:'商品----01'},{key:'商品----02'},
           {key:'商品----03'},{key:'商品----04'},
           {key:'商品----05'},{key:'商品----06'}]}
           ListHeaderComponent={ReCycleView}
           renderItem={({item})=><Text style={{textAlign:'center',backgroundColor:'#53e021'}}>{item.key}</Text>}
         />
      </View>

    );
  }
}

var styles = StyleSheet.create({
  container:{
    flex:1,

  }
})
