package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class TypographyDisplay extends Typography
  {
    public function TypographyDisplay()
    {
      super();
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return super.createElement();
    }
    override public function set size(value:Number):void{
      super.size = value;
      switch(value){
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:toggle("spectrum-Heading"+value+"--display",true);
          break;
      }
    }
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
        var theSize:Number = super.size;
        if(theSize){
          toggle("spectrum-Heading"+theSize+"--quiet",value)
        }
      }
    	_quiet = value;
    }
    private var _strong:Boolean;

    public function get strong():Boolean
    {
    	return _strong;
    }

    public function set strong(value:Boolean):void
    {
      if(value != !!_strong){
        var theSize:Number = super.size;
        if(theSize){
          toggle("spectrum-Heading"+theSize+"--strong",value)
        }
      }
    	_strong = value;
    }
  }
}