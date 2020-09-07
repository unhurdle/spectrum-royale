package com.unhurdle.spectrum.typography
{
  import org.apache.royale.html.elements.Span;

  COMPILE::JS
  {
  }
  

  public class Detail extends Typography
  {
    public function Detail()
    {
      super();
    }
    private var span:Span;
    override protected function getSelector():String{
      return "spectrum-Detail";
    }

    override protected function getSizes():Array{
      return[
        "S",
        "M",
        "L",
        "XL",
      ];
    }

    private var _lightText:String;

    public function get lightText():String
    {
    	return _lightText;
    }

    public function set lightText(value:String):void
    {
    	_lightText = value;
      if(span){
        span.text = value;
      }
    }
    private var _light:Boolean;

    public function get light():Boolean
    {
    	return _light;
    }

    public function set light(value:Boolean):void
    {
      if(value != !!_light){
        if(value && !span){
          span = new Span();
          span.className = valueToSelector("light");
          span.text = lightText;
          addElement(span);
        }else if(!value && span){
          removeElement(span);
          span = null;
        }
      }
      _light = value;
    }
  }
}