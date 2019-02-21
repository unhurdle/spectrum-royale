package com.unhurdle.spectrum.data
{
  public class SideNavItem
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
    private var _dataProvider:Array = [];
    public function get dataProvider():Object
    {
    	return _dataProvider;
    }
    public function set dataProvider(value:Object):void
    {
    	_dataProvider.push(value);
    }
    private var _height:String;

    public function get height():String
    {
        return _height;
    }

    public function set height(value:String):void
    {
        _height = value;
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
        
    private var _color:String;

    public function get color():String
    {
        return _color;
    }
     public function set color(value:String):void
    {
        _color = value;
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