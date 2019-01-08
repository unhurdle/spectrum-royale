package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  public class Form extends SpectrumBase
  {
    public function Form()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Form";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,'form');
    }
  }
}