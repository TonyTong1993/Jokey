import {
  Dimensions,
  PixelRatio,
} from 'react-native';
 const screen_width = Dimensions.get('window').width;
 const onePixel = 1/PixelRatio.get();
 module.exports = {
   screen_width:screen_width,
   onePixel:onePixel
 };
