package com.unhurdle.spectrum
{
  public class TypographyGroup extends TextGroup
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
      tabFocusable = false;
      userSelect = false;
    }
    override protected function getSelector():String{
      return "spectrum-Typography";
    }

    private var _userSelect:Boolean;

    public function get userSelect():Boolean
    {
    	return _userSelect;
    }

    public function set userSelect(value:Boolean):void
    {
    	_userSelect = value;
      if(value){
        setAttribute("user-select","");
      } else {
        setAttribute("user-select","none");
      }
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
          if(value == 'he' || value == 'ar'){
            setAttribute("dir","rtl")
          }
          else{
            removeAttribute("dir");
          }
          setAttribute("lang",value);
        } else {
          removeAttribute("lang");
          removeAttribute("dir");
        }
      }
    }
  }
}