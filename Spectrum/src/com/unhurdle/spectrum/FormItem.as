package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  public class FormItem extends SpectrumBase
  {
    public function FormItem()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Form-item";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'div');
      label = new Label();
      addElement(label);
      return element;
    }
    public var label:Label;
  }
}