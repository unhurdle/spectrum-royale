package com.unhurdle.spectrum
{
  public class Popover extends Group
  {
    public function Popover()
    {
      
    }
    override protected function getSelector():String{
      return "spectrum-Popover";
    }
    private var _open:Boolean;

    public function get open():Boolean
    {
    	return _open;
    }

    public function set open(value:Boolean):void
    {
    	_open = value;
      toggle("is-open",value);
    }

    private var _relativePosition:Boolean;

    public function get relativePosition():Boolean
    {
    	return _relativePosition;
    }

    public function set relativePosition(value:Boolean):void
    {
      if(value != !!_relativePosition){
      	_relativePosition = value;
        COMPILE::JS
        {
          if(value){
            element.style.position = "relative";
          } else {
            element.style.position = null;
          }
        }
      }
    }
  }
}