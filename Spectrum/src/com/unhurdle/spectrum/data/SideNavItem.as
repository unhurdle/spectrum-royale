package com.unhurdle.spectrum.data
{
  public class SideNavItem extends MenuItem
  {
    public function SideNavItem(text:String = null)
    {
      this.text = text;
    }
    private var _isList:Boolean;
    public function get isList():Boolean
    {
    	return _isList;
    }
    public function set isList(value:Boolean):void
    {
    	_isList = value;
    }
    //TODO is this needed?
    private var _href:String;
    public function get href():String
    {
    	return _href;
    }
    public function set href(value:String):void
    {
      if(value){
    	  _href = value;
      }
    }
    private var _text:String;
  }
}