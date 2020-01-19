package com.unhurdle.spectrum
{
  public class TypographyGroup extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/typography/dist.css">
     * </inject_html>
     * 
     */
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
          setAttribute("lang",value);
        } else {
          removeAttribute("lang");
        }
      }
    }
  }
}