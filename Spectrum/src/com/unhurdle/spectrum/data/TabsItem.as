package com.unhurdle.spectrum.data
{
  import com.unhurdle.spectrum.generateSVG;

  public class TabsItem
  {
    public function TabsItem(text:String = null)
    {
      this.text = text;
    }
    private var _text:String;
    private var _icon:String;
   
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
    
    public function get icon():String{
      return _icon;
    }
    public function set icon(value:String):void{
      _icon = value;
    }
  }
}