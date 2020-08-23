package com.unhurdle.spectrum.includes
{
  public class FieldLabelInclude
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/fieldlabel/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */
    public function FieldLabelInclude()
    {
      
    }
    public static function getSelector():String{
      return "spectrum-FieldLabel";
    }
    public static function getFormSelector():String{
      return "spectrum-Form";
    }
  }
}