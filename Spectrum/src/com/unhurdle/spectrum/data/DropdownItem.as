package com.unhurdle.spectrum.data
{
  public class DropdownItem
  {
    public function DropdownItem(text:String = null)
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
    private var _isDivider:Boolean;

    public function get isDivider():Boolean
    {
    	return _isDivider;
    }

    public function set isDivider(value:Boolean):void
    {
    	_isDivider = value;
    }

    private var _icon:String;

    public function get icon():String
    {
    	return _icon;
    }

    public function set icon(value:String):void
    {
    	_icon = value;
    }
  }
}