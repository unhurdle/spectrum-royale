package com.unhurdle.spectrum
{
  public class TypographyGroup extends Group
  {
    public function TypographyGroup()
    {
      super();
    }

    private var _language:String;

    public function get language():String
    {
    	return _language;
    }

    public function set language(value:String):void
    {
    	_language = value;
      COMPILE::JS
      {
        if(value){
          element.setAttribute("lang",value);
        } else {
          element.removeAttribute("lang");
        }
      }
    }
  }
}