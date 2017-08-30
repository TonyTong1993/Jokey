import React from 'react'
import {
  StyleSheet,
  View,
  ScrollView,
  Text
} from 'react-native'

export default class ReCycleView extends React.Component{
    render() {
      return (
        <ScrollView
          contentContainerStyle={styles.container}
          horizontal={true}
          >
          <Text >头部</Text>
        </ScrollView>
      )
    }
}

var styles = StyleSheet.create({
  container: {
    flex:1,
    height:120,
    backgroundColor:'#ffb300',
    justifyContent:'center',
    alignItems:'center'
  }
})
