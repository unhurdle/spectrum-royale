package com.unhurdle.spectrum
{

  public class Accordion extends Group
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/accordion/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */

    public function Accordion()
    {
      super();
    }

    override protected function getSelector():String{
      return "spectrum-Accordion";
    }

  }
}