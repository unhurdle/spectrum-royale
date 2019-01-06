package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class TypographyCode extends Typography
  {
    public function TypographyCode()
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
        case 5:toggle("spectrum-Code"+value,true);
          break;
      }
    }
  }
}