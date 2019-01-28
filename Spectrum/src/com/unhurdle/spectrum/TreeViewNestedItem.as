package com.unhurdle.spectrum
{
  public class TreeViewNestedItem
  {
    public function TreeViewNestedItem(value:String)
    {
      text = value
    }
    private var _opened:Boolean = false;
    public function get opened():Boolean
    {
    	return _opened;
    }
    public function set opened(value:Boolean):void
    {
    	_opened = value;
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
    
    private var _dataProvider:Array = [];
    public function get dataProvider():Object
    {
    	return _dataProvider;
    }
    public function set dataProvider(value:Object):void
    {
    	_dataProvider.push(value);
    }
    private var _href:String;
    public function get href():String
    {
    	return _href;
    }
    public function set href(value:String):void
    {
      if(!!value){
    	  _href = value;
      }
      if(!!_href){
        _href = "#";
      }
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