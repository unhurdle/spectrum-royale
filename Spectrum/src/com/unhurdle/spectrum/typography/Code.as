package com.unhurdle.spectrum.typography
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.TextNode;

  public class Code extends Typography
  {
    public function Code()
    {
      super();
    }
    override protected function getTypographySelector():String{
      return "spectrum-Code";
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,"code");
      textNode = new TextNode("");
      textNode.element = element;
      return element;
    }

  }
}