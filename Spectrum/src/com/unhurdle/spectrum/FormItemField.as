package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  public class FormItemField extends SpectrumBase
  {
    public function FormItemField()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Form-itemField";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,'div');
    }
  }
}