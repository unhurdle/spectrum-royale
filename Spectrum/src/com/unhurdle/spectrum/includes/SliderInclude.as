package com.unhurdle.spectrum.includes
{
  public class SliderInclude
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/slider/dist.css">
     * </inject_html>
     * 
     */
    public function SliderInclude()
    {
      
    }
    public static function getSliderSelector():String{
      return "spectrum-Slider";
    }
    public static function getDialSelector():String{
      return "spectrum-Dial";
    }
  }
}