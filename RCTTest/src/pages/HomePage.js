'use strict';

import React, { Component } from 'react';
import {
  StyleSheet,
  View,
  Text,
  FlatList,
  Image,
  Button,
  TouchableOpacity,
} from 'react-native';
import CodePush from 'react-native-code-push' 
import ReCycleView from '../components/ShopHeader'
import SearchHeader from '../components/SearchHeader'
import ShopFooter from '../components/ShopFooter'
import RowBanner from '../components/RowBanner'
import ThirdBanner from '../components/ThirdBanner'
import {screen_width,screen_height} from '../Config'

let codePushOptions = { checkFrequency: CodePush.CheckFrequency.ON_APP_RESUME };

const data = [
              {key:'http://img63.ddimg.cn/upload_img/00721/zjl/640x342_wzh_20170830.jpg'},
              {key:[{key:'图书'},{key:'电子书'},{key:'网络文学'},{key:'当当优品'},{key:'当当优品'},
                    {key:'童书'},{key:'母婴'},{key:'玩具'},{key:'童装童鞋'},{key:'创意文具'},
                    {key:'女装'},{key:'男装'},{key:'内衣配饰'},{key:'鞋靴箱包'},{key:'户外活动'},
                    {key:'美妆个护'},{key:'食品'},{key:'运营健康'},{key:'珠宝手表'},{key:'当当优选'},
                    {key:'家居家纺'},{key:'家电'},{key:'Apple'},{key:'手机数码'},{key:'图书榜'}]},
              {key:'商品---003'},
                  ]

class HomePage extends Component {
	static navigationOptions = ({navigation}) =>({
     header:()=>{
       return <SearchHeader
                headerCategoryClicked={()=>navigation.navigate('Search')}
                headerSearchClicked={()=>navigation.navigate('Search')}
                headerMessageClicked={()=>navigation.navigate('Search')}/>
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
           ListHeaderComponent={this._ListHeaderComponent}
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
  componentWillMount() {
       CodePush.disallowRestart();//页面加载的禁止重启，在加载完了可以允许重启
  }
componentDidMount() {
    CodePush.allowRestart();//在加载完了可以允许重启
}
  /*private method*/
  _renderItem =({item,index}) =>{
    console.log(item.key)
    switch (index) {
      case 0:
      return   (
          <TouchableOpacity onPress={this._headrCategoryClicked}>
            <View >
              <Image style={styles.firstBanner} source={{uri:item.key}}/>
            </View>
          </TouchableOpacity>
           )

        break;
        case 1:
        return <RowBanner  data={item.key} onPress={this._headrCategoryClicked}/>
          break;
        case 2:
        return <ThirdBanner onPress={this._headrCategoryClicked}/>
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
  _ListHeaderComponent = ()=>{
    return <ReCycleView onPress={this._headrCategoryClicked}/>
  }
  _loadNewData =()=>{
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
    justifyContent: 'center',
    alignItems: 'center',
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
function syncImmediate () {
  CodePush.sync(

             { installMode: CodePush.InstallMode.IMMEDIATE,//启动模式三种：ON_NEXT_RESUME、ON_NEXT_RESTART、IMMEDIATE

                updateDialog: {

                        appendReleaseDescription:true,//是否显示更新description，默认为false

                        descriptionPrefix:"更新内容：",//更新说明的前缀。 默认是” Description:

                        mandatoryContinueButtonLabel:"立即更新",//强制更新的按钮文字，默认为continue

                        mandatoryUpdateMessage:"",//- 强制更新时，更新通知. Defaults to “An update is available that must be installed.”.

                        optionalIgnoreButtonLabel: '稍后',//非强制更新时，取消按钮文字,默认是ignore

                       optionalInstallButtonLabel: '后台更新',//非强制更新时，确认文字. Defaults to “Install”

                      optionalUpdateMessage: '有新版本了，是否更新？',//非强制更新时，更新通知. Defaults to “An update is available. Would you like to install it?”.

                      title: '更新提示'//要显示的更新通知的标题. Defaults to “Update available”.

                  },

            },

        );
}
syncImmediate();
let MyApp = CodePush(codePushOptions)(HomePage);
export default MyApp;
