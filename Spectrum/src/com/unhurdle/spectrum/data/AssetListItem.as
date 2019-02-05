package com.unhurdle.spectrum.data
{
  public class AssetListItem
  {
    public function AssetListItem(text:String = null)
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
    private var _isBranch:Boolean;

    public function get isBranch():Boolean
    {
    	return _isBranch;
    }

    public function set isBranch(value:Boolean):void
    {
    	_isBranch = value;
    }
    private var _isChild:Boolean;

    public function get isChild():Boolean
    {
    	return _isChild;
    }

    public function set isChild(value:Boolean):void
    {
    	_isChild = value;
    }
    private var _selectable:Boolean;

    public function get selectable():Boolean
    {
    	return _selectable;
    }

    public function set selectable(value:Boolean):void
    {
    	_selectable = value;
    }

    private var _iconType:String;

    public function get iconType():String
    {
    	return _iconType;
    }

    public function set iconType(value:String):void
    {
    	_iconType = value;
    }
    private var _src:String;

    public function get src():String
    {
    	return _src;
    }

    public function set src(value:String):void
    {
    	_src = value;
    }
  }
}