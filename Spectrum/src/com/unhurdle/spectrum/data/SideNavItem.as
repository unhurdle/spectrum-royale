package com.unhurdle.spectrum.data
{
  public class SideNavItem
  {
    public function SideNavItem(text:String = null)
    {
      this.text = text;
    }

    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
    }
    public function get label():String{
      return _text;
    }
    private var _selected:Boolean;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
    	_selected = value;
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
    	_disabled = value;
    }
    private var _isHeading:Boolean;

    public function get isHeading():Boolean
    {
    	return _isHeading;
    }

    public function set isHeading(value:Boolean):void
    {
    	_isHeading = value;
    }
  }
}