'use strict';

import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  Text,
  FlatList,
} from 'react-native';
import movieStore from '../../store/test/MovieStore';
import { GetMovies } from '../../actions/test/LoadMoviesAction'

class ReduxPage extends Component {
  _unsubscribe:any;
  constructor(props) {
    super(props);
    this.state = {
      movies:[]
    };
  }
  render() {
    return (
      <View style={styles.container}>
        <FlatList
          data={this.state.movies}
          keyExtractor={this._keyExtractor}
          renderItem = {this._renderItem}
        />
      </View>
    );
  }
  componentDidMount() {
  movieStore.dispatch(GetMovies('https://facebook.github.io/react-native/movies.json'));
  this._unsubscribe = movieStore.subscribe(()=>{
     var obj = movieStore.getState();
     const { movies } = obj.payload;
     this.setState({
       movies
     });
   });
  }
  componentWillUnmount() {
    this._unsubscribe();
  }

  _keyExtractor = (item,index)=>{
    return `${item.title}-${index}`;
  }
  _renderItem = ({item})=>{
    return (
      <View style={styles.item}>
        <Text>{item.title}</Text>
        <Text>{item.releaseYear}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
    container:{
      flex:1,
      justifyContent:'center',
      alignItems:'center'
    },
    item:{
      height:44,
      paddingLeft:12,
      paddingRight:12,
      flexDirection:'row',
    }
});


export default ReduxPage;
