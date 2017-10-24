 'use strict';

 import React, { Component } from 'react';
 import { createStore } from 'redux';
 import { Provider } from 'react-redux';
 import { todos } from '../../reducer/test/TodoReducer';
 import { addTodo } from '../../actions/test/TodoAction'
 import {
   StyleSheet,
   View,
   Text,
   TextInput,
   Button,
   FlatList,
 } from 'react-native';

 /*
 一、store的概念
 createStore是store生成器，store相当于整运用的数据容器，
 你可以把它看成一个json数据表，其反应了整个运用的可变状态信息，
 当每有一个节点发生变化都会使界面发生变化；
 const store = createStore(func) fun为reducer函数即纯函数->同样的输入对应同样的输出。
 二、state的概念
 store是存储state的容器，state的获取方式如下
 const state = store.getState()
 Redux规定，一个state对应一个View。只要state相同，View就相同。你知道 State，就知道 View 是什么样，反之亦然。
 三、action的概览
 State 的变化，会导致 View 的变化。但是，用户接触不到 State，只能接触到 View。所以，State 的变化必须是 View 导致的。Action 就是 View 发出的通知，表示 State 应该要发生变化了。
 Action 是一个对象。其中的type属性是必须的，表示 Action 的名称。其他属性可以自由设置，社区有一个规范可以参考。
 例如：
 const action = {
  type: 'ADD_TODO',
  payload: 'Learn Redux'
};
reducer 案例：
 State -> 是一个对象
function reducer(state, action) {
  return Object.assign({}, state, { thingToChange });
  // 或者
  return { ...state, ...newState };
}

 State -> 是一个数组
function reducer(state, action) {
  return [...state, newItem];
}

Store 允许使用store.subscribe方法设置监听函数，一旦 State 发生变化，就自动执行这个函数。
import { createStore } from 'redux';
const store = createStore(reducer);
store.subscribe(listener);
显然，只要把 View 的更新函数（对于 React 项目，就是组件的render方法或setState方法）放入listen，就会实现 View 的自动渲染。
store.subscribe方法返回一个函数，调用这个函数就可以解除监听。
let unsubscribe = store.subscribe(() =>
  console.log(store.getState())
);

unsubscribe();

四、可以发现 Store 提供了三个方法:
1.store.getState()
2.store.dispatch()
3.store.subscribe()
createStore方法还可以接受第二个参数，表示 State 的最初状态。这通常是服务器给出的
let store = createStore(todoApp, window.STATE_FROM_SERVER)

五、Reducer 的拆分
 */
 const store = createStore(todos);
 /*
 迈出一小步
  const state = store.getState();
 console.log(state);//打印结果->["welcome to todo app!"]
 store.dispatch(addTodo('learn redux'));
 const newState = store.getState();
 console.log(newState);//打印结果->["welcome to todo app!", "learn redux"]
 */
 /*
  再迈出一小步
   store.subscribe(()=>{
    var state = store.getState();
     console.log(state); //打印结果->["welcome to todo app!", "learn redux"]
  });
   store.dispatch(addTodo('learn redux'));
 */

 class ReduxPage extends Component {
  constructor(props) {
    super(props);
  
    this.state = {
      text:'',
    };
  }
  _textInput:any;
   render() {
     return (
       <View style={styles.container}>
       		<View style={styles.inputView}>
            <TextInput 
            ref={component=>(this._textInput = component)}
            style={{flex:1,height:32,borderColor:'gray',borderWidth:1,borderRadius:16,paddingLeft:20}}
            placeholder='请添加待办事项'
            onChangeText={ (text)=> this.setState({
              text
            })}
            value={this.state.text}/>
            <Button
            style={{backgroundColor:'green'}} 
            onPress={this._addTodo} title='addTodo'
            color="#841584"
           />
          </View>
       </View>
     );
   }
   _addTodo =(text)=> {
      if (text.length == 0) {
        return;
      };
      this.setState({
        text:'' 
      });
      this._textInput.un
      store.dispatch(addTodo(text))
   }
 }

 const styles = StyleSheet.create({
	 container:{
    flex:1,
	 	alignItems: 'center',
    paddingTop:20,
	 },
   inputView:{
    flexDirection:'row',
    paddingLeft:10,
    paddingRight:10,
   }
 });


 export default ReduxPage;
