package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;

  public class List extends org.apache.royale.html.List
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/menu/dist.css">
     * </inject_html>
     * 
     */
    public function List()
    {
      super();
      typeNames = "spectrum-Menu";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'div');
    }
  }
}