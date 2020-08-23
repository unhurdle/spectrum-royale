package com.unhurdle.spectrum.includes
{
  public class SideNavInclude
  {

    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/sidenav/dist.css");
     * document.head.appendSelector(link);
     * </inject_script>
     */
    public function SideNavInclude()
    {
      
    }
    public static function getSelector():String{
      return "spectrum-SideNav";
    }
  }
}