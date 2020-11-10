package com.unhurdle.spectrum.data
{
  public class MenuItem extends ListItem implements IMenuItem
  {
    public function MenuItem(text:String = null)
    {
      super(text);
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
    private var _isOpen:Boolean = false;

    public function get isOpen():Boolean
    {
    	return _isOpen;
    }

    public function set isOpen(value:Boolean):void
    {
    	_isOpen = value;
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

    private var _subMenu:Array;

    public function get subMenu():Array
    {
    	return _subMenu;
    }

    public function set subMenu(value:Array):void
    {
    	_subMenu = value;
    }
  }
}