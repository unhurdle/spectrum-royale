package com.unhurdle.spectrum
{
    COMPILE::JS{
      import org.apache.royale.core.WrappedHTMLElement;
      import org.apache.royale.html.util.addElementToWrapper;
    }
  public class Well extends SpectrumBase
  {
    public function Well()
    {
      super();
      typeNames = "spectrum-Well";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'span');
      return elem;
    }
  }
}