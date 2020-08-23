package com.unhurdle.spectrum
{
    COMPILE::JS{
      import org.apache.royale.core.WrappedHTMLElement;
      import org.apache.royale.html.util.addElementToWrapper;
    }
  public class Well extends Group
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/well/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */
    public function Well()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Well";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,'span');
    }
  }
}