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
    private var _isTitle:Boolean;

    public function get isTitle():Boolean
    {
    	return _isTitle;
    }

    public function set isTitle(value:Boolean):void
    {
    	_isTitle = value;
    }
  }
}