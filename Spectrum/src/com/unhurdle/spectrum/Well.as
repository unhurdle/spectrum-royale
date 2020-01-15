package com.unhurdle.spectrum
{
    COMPILE::JS{
      import org.apache.royale.core.WrappedHTMLElement;
      import org.apache.royale.html.util.addElementToWrapper;
    }
  public class Well extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/well/dist.css">
     * </inject_html>
     * 
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