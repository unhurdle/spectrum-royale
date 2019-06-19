package com.unhurdle.spectrum
{
  import org.apache.royale.core.IPopUp;

  public class Popover extends Group implements IPopUp
  {
    public function Popover()
    {
      super();
      COMPILE::JS
      {
        element.style.zIndex = 500;// very high number to makie sure it's above everything else
      }

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

    private var _position:String;

    public function get position():String
    {
    	return _position;
    }

    public function set position(value:String):void
    {
      if(value != _position){
        if(!value){
          value = "bottom";
        }
        switch(value)
        {
          case "bottom":
          case "top":
          case "right":
          case "left":
            break;
        
          default:
            throw new Error("invalid position: " + value);
            
        }
        if(_position){
          toggle(valueToSelector(_position),false);
        }
        toggle(valueToSelector(value),true);
      	_position = value;
      }
    }

  }
}