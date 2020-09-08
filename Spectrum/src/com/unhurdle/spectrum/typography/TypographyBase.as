package com.unhurdle.spectrum.typography
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.TypographyGroup;

  public class TypographyBase extends TypographyGroup
  {
    public function TypographyBase()
    {
      super();
    }

    override protected function getTag():String{
      return "p";
    }
  }
}