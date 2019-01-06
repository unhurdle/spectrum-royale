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