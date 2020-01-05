package com.unhurdle.spectrum
{
  public class ButtonGroup extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/buttongroup/dist.css">
     * </inject_html>
     * 
     */

    public function ButtonGroup()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-ButtonGroup";
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