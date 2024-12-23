package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.SpectrumBase;

  import org.apache.royale.debugging.assert;

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
        var elem:HTMLElement = element as HTMLElement;
          if(value){
            assert(value.indexOf('"') == -1, "Double quotes should be url-encoded in the background image src string");
            elem.style.backgroundImage = 'url("' + value +'")';
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