package com.unhurdle.spectrum
{
  public class VDivider extends Divider
  {
    public function VDivider()
    {
      super();
      vertical = true;
    }

    private var _fitHeight:Boolean;

    public function get fitHeight():Boolean
    {
    	return _fitHeight;
    }

    public function set fitHeight(value:Boolean):void
    {
      if(value != !!_fitHeight){
        if(value){
          setStyle("height", "auto");
          setStyle("align-self","stretch");
        } else {
          setStyle("align-self","");
          // was the height explicitely set?
          if(!isNaN(_height)){
            height = _height;
          }
        }
      }
    	_fitHeight = value;
    }

  }
}