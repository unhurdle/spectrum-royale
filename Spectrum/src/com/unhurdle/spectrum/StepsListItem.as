package com.unhurdle.spectrum
{
  public class StepsListItem
  {
    public function StepsListItem(value: String)
    {
      this.text = value;
    }
    
    // private var _withLabel:Boolean;
    // public function get withLabel():Boolean
    // {
    // 	return _withLabel;
    // }
    // public function set withLabel(value:Boolean):void
    // {
    // 	_withLabel = value;
    // }
    private var _selected:Boolean;
    public function get selected():Boolean
    {
    	return _selected;
    }
    public function set selected(value:Boolean):void
    {
    	_selected = value;
    }
    private var _toolTip:Boolean;
    public function get toolTip():Boolean
    {
    	return _toolTip;
    }
    public function set toolTip(value:Boolean):void
    {
    	_toolTip = value;
    }
    
    private var _completed:Boolean;
    public function get completed():Boolean
    {
    	return _completed;
    }
    public function set completed(value:Boolean):void
    {
    	_completed = value;
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
  }
}