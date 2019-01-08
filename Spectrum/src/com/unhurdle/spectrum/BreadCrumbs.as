package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;
  public class BreadCrumbs extends org.apache.royale.html.List
  {
    public function BreadCrumbs()
    {
      super();
      typeNames = "spectrum-Breadcrumbs";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'div');
    }
  }
}