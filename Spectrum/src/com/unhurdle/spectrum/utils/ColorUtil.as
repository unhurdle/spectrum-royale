package com.unhurdle.spectrum.utils
{

  public class ColorUtil
  {
    private function ColorUtil(){}

    public static function rgbStr(rgbArr:Array):String{
      var str:String = "rgb(" + rgbArr[0] + "," + rgbArr[1] + "," + rgbArr[2];
      if(!!rgbArr[3]){
        return str + "," + rgbArr[3] + ")";
      }
      return str + ")";
    }
  }
}