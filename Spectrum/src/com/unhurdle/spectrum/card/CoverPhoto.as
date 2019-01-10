package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.SpectrumBase;

  public class CoverPhoto extends SpectrumBase
  {
    public function CoverPhoto(src:String)
    {
      super();
      if(src)
        this.src = src;
    }
    private var _src:String;

    public function get src():String
    {
    	return _src;
    }

    public function set src(value:String):void
    {
      if(value != _src){
        _src = value;
        COMPILE::JS
        {
          if(value){
            element.style.backgroundImage = "url(" + value +")";
          } else {
            element.style.backgroundImage = null;
          }
        }
      }
    }
    override protected function getSelector():String{
      return getCardSelector() + "-coverPhoto";
    }
  }
}