package com.unhurdle.spectrum.data
{
  // public class MenuItem implements IMenuItem
  public class MenuItem
  {
    public function MenuItem(text:String = null)
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

    private var _icon:String;

    public function get icon():String
    {
    	return _icon;
    }

    public function set icon(value:String):void
    {
    	_icon = value;
    }

    private var _imageIcon:String;
    /**
     * src of an icon to be rendered an an img
     */
    public function get imageIcon():String
    {
    	return _imageIcon;
    }

    public function set imageIcon(value:String):void
    {
    	_imageIcon = value;
    }

    private var _dataProvider:Array=[];

    public function get dataProvider():Array
    {
    	return _dataProvider;
    }

    public function set dataProvider(value:Array):void
    {
    	_dataProvider = value;
    }

    private var _subMenu:Boolean;

    public function get subMenu():Boolean
    {
    	return _subMenu;
    }

    public function set subMenu(value:Boolean):void
    {
    	_subMenu = value;
    }

  }
}