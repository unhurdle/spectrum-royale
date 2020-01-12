package com.unhurdle.spectrum.data
{
  public class ListItem implements IListItem
  {
    public function ListItem(text:String="")
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
  }
}