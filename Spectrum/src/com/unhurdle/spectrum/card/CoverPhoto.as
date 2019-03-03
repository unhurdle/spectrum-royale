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
      (element as HTMLElement).style.height = "inherit";
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
        var elem:HTMLElement = element as HTMLElement;
          if(value){
            elem.style.backgroundImage = "url(" + value +")";
          } else {
            elem.style.backgroundImage = null;
          }
      }
    }
    override protected function getSelector():String{
      return getCardSelector() + "-coverPhoto";
    }
  }
}