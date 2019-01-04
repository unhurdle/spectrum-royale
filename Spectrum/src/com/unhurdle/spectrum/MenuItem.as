package com.unhurdle.spectrum
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class MenuItem extends DataItemRenderer
  {
    public function MenuItem()
    {
      super();
      typeNames = 'spectrum-Menu-item';
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'li');
    }

  }
}