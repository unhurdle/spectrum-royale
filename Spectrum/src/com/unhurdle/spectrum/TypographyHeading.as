package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class TypographyHeading extends Typography
  {
    public function TypographyHeading()
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
        case 5:toggle("spectrum-Heading"+value,true);
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
        if(theSize && value){
         toggle("spectrum-Heading"+theSize,false);
         toggle("spectrum-Heading"+theSize+"--quiet",true);
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
        if(theSize && value){
          toggle("spectrum-Heading"+theSize,false);
          toggle("spectrum-Heading"+theSize+"--strong",true);
        }
      }
    	_strong = value;
    }
  }
}