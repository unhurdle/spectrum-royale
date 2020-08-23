package com.unhurdle.spectrum.includes
{
  public class IconInclude
  {

    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/icon/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */
    public function IconInclude()
    {
    }
    public static function getSelector():String{
      return "spectrum-Icon";
    }
  }
}