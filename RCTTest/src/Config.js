import {
  Dimensions,
  PixelRatio,
} from 'react-native';
 const screen_width = Dimensions.get('window').width;
 const screen_height = Dimensions.get('window').height;
 const onePixel = 1/PixelRatio.get();
 module.exports = {
   screen_width:screen_width,
   screen_height:screen_height,
   onePixel:onePixel
 };
