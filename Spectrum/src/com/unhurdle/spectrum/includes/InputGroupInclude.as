package com.unhurdle.spectrum.includes
{
  public class InputGroupInclude
  {

    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/inputgroup/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */
    public function InputGroupInclude()
    {
      
    }
    public static function getSelector():String{
      return "spectrum-InputGroup";
    }
  }
}