package com.unhurdle.spectrum.typography
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.TextNode;

  public class Detail extends TypographyBase
  {
    public function Detail()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Detail";
    }
  }
}