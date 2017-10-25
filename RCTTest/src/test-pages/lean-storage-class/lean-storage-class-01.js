/* @flow */

import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
} from 'react-native';
import AV from 'leancloud-storage';

//初始化
var APP_ID = 'NFoSJtb7At6GMvIann2SmEwf-gzGzoHsz';
var APP_KEY = '30Gc2EalkdP1PPyvzhw2DCVU';

AV.init({
  appId: APP_ID,
  appKey: APP_KEY
});
/*
// Node.js 中设置环境变量 DEBUG=leancloud*
// 通过 npm 启动应用时打开调试
DEBUG=leancloud* npm start

// 若使用云引擎 Node.js 环境，进入 LeanCloud 应用控制台 > 云引擎 > 设置 > 自定义环境变量，
// 第一字段写 DEBUG，第二个字段写 leancloud:*，保存。（注意 leancloud 和 * 之间有个冒号）
// 或使用云引擎 CLI 启动应用时打开调试，日志会输出到 应用控制台 > 云引擎 > 日志：
DEBUG=leancloud:* lean up

// 浏览器的 Console 中设置 localStorage
localStorage.setItem('debug', 'leancloud*');

var TestObject = AV.Object.extend('TestObject');
var testObject = new TestObject();
testObject.save({
  words: 'Hello World!'
}).then(function(object) {
  alert('LeanCloud Rocks!');
})

*/






export default class LeanStoragePage extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>I'm the LeanStoragePage component</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
