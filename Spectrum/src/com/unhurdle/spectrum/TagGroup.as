package com.unhurdle.spectrum
{
  public class TagGroup extends Group
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/tags/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */
    public function TagGroup()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Tags";
    }
  }
}