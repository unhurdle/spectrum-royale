package com.unhurdle.spectrum.data
{
  public class TreeViewNestedItem
  {
    public function TreeViewNestedItem(value:String)
    {
      text = value;
    }
    private var _withIcon:Boolean = false;
    public function get withIcon():Boolean{
    	return _withIcon;
    }
    public function set withIcon(value:Boolean):void{
    	_withIcon = value;
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
    private var _disabled:Boolean;
    public function get disabled():Boolean
    {
    	return _disabled;
    }
    public function set disabled(value:Boolean):void
    {
    	_disabled = value;
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