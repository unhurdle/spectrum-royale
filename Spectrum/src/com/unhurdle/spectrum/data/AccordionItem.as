package com.unhurdle.spectrum.data
{
  public class AccordionItem
  {
    public function AccordionItem(text:String = null)
    {
      this.headerText = text;
    }
    private var _headerText:String;

    public function get headerText():String
    {
    	return _headerText;
    }

    public function set headerText(value:String):void
    {
    	_headerText = value;
    }
    private var _contentText:String;

    public function get contentText():String
    {
    	return _contentText;
    }

    public function set contentText(value:String):void
    {
    	_contentText = value;
    }
    
    private var _isOpen:Boolean;

    public function get isOpen():Boolean
    {
    	return _isOpen;
    }

    public function set isOpen(value:Boolean):void
    {
    	_isOpen = value;
    }

    private var _isDisabled:Boolean;

    public function get isDisabled():Boolean
    {
    	return _isDisabled;
    }

    public function set isDisabled(value:Boolean):void
    {
    	_isDisabled = value;
    }
  }
}