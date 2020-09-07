package com.unhurdle.spectrum.typography
{
  /**
   * Subtitle can be size 1 through 3.
   * Size 1 is equivalent to Heading4
   * Size 2 is equivalent to Heading6
   * Size 3 is equivalent to Subheading
   */
  public class Subtitle extends Heading
  {
    public function Subtitle()
    {
      super();
      typeNames = "";
    }
    override protected function getSelector():String{
      return getTypographySelector() + "--subtitle";
    }
    override public function validateSize(value:String):Boolean{
      var numVal:Number = Number(value);
      if(!isNaN(numVal) && numVal<=3 && numVal>=1){
        return true;
      }
      return false;
    }
    override public function set size(value:String):void
    {
      if(!value || value == _size){
        return;
      }
      if(!validateSize(value)){
          throw new Error("invalid size: " + value);
      }
      if(_size){
        toggle(appendSelector(_size),false);
      }
    	_size = value;
      toggle(appendSelector(value),true);
    }
  }
}