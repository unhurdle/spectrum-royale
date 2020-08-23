package com.unhurdle.spectrum
{
  public class TypographyGroup extends Group
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/typography/dist.css");
     * document.he.appendChild(link);
     * </inject_script>
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