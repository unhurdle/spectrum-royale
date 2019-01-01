package com.unhurdle.spectrum
{
  public class ButtonGroup extends Group
  {
    public function ButtonGroup()
    {
      super();
      typeNames = "spectrum-ButtonGroup";
    }
    private var _vertical:Boolean;
    public function get vertical():Boolean
    {
        return _vertical;
    }
    public function set vertical(value:Boolean):void
    {
      if(value != !!_vertical){
        toggle("spectrum-ButtonGroup--vertical",value);
      }
      _vertical = value;
    }
  }
}