package com.unhurdle.spectrum
{
  public class FieldGroup extends Group
  {
    public function FieldGroup()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-FieldGroup";
    }
    private var _vertical:Boolean;

    public function get vertical():Boolean
    {
    	return _vertical;
    }
    
    public function set vertical(value:Boolean):void
    {
      if(value != !!_vertical){
        toggle(valueToSelector("vertical"),value);
      }
    	_vertical = value;
    }
  }
}