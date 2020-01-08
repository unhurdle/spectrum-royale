package com.unhurdle.spectrum.data
{
  public class BreadcrumbsItem
  {
    public function BreadcrumbsItem(text:String = null)
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
    private var _isTitle:Boolean;

    public function get isTitle():Boolean
    {
    	return _isTitle;
    }

    public function set isTitle(value:Boolean):void
    {
    	_isTitle = value;
    }
    private var _isFolder:Boolean = false;

    public function get isFolder():Boolean
    {
    	return _isFolder;
    }

    public function set isFolder(value:Boolean):void
    {
    	_isFolder = value;
    }
    private var _isDragged:Boolean = false;

    public function get isDragged():Boolean
    {
    	return _isDragged;
    }

    public function set isDragged(value:Boolean):void
    {
    	_isDragged = value;
    }
  }
}