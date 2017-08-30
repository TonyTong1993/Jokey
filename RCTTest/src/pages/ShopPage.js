import React from 'react'
import {
  StyleSheet,
  View,
  Text,
  FlatList,
} from 'react-native'
import ReCycleView from '../components/ShopHeader'
export default class ShopPage extends React.Component {

  render() {
    return (
      <FlatList
        contentContainerStyle={styles.container}
        data={[{key:'商品----01'},{key:'商品----02'},
        {key:'商品----03'},{key:'商品----04'},
        {key:'商品----05'},{key:'商品----06'}]}
        ListHeaderComponent={ReCycleView}
        renderItem={({item})=><Text style={{textAlign:'center',backgroundColor:'#53e021'}}>{item.key}</Text>}
        ListFooterComponent={ReCycleView}
      />

    );
  }
}

var styles = StyleSheet.create({
  container:{
    flex:1,
  }
})
