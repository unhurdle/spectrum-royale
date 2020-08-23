package com.unhurdle.spectrum.includes
{
  public class SliderInclude
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/slider/dist.css");
     * document.head.appendSelector(link);
     * </inject_script>
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