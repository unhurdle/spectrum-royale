package com.unhurdle.spectrum.data
{
  public class AssetListItem extends ListItem
  {
    public function AssetListItem(text:String = null)
    {
      super(text);
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
    // private var _selected:Boolean;

    // public function get selected():Boolean
    // {
    // 	return _selected;
    // }

    // public function set selected(value:Boolean):void
    // {
    // 	_selected = value;
    // }

  }
}