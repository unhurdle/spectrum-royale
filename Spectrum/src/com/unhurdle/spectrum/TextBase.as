package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  public class TextBase extends SpectrumBase
  {
    public function TextBase()
    {
      super();
    }

    protected var textNode:TextNode;
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,"div");
      textNode = new TextNode("");
      textNode.element = elem;
      return elem;
    }

  }
}