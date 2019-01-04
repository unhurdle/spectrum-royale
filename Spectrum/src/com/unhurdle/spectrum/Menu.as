package com.unhurdle.spectrum
{
  import org.apache.royale.html.List;
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  public class Menu extends List
  {
    public function Menu()
    {
      super();
      typeNames = "spectrum-Menu";
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'ul');
    }
  }
}