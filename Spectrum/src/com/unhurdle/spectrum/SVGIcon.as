package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class SVGIcon extends Icon
  {
    public function SVGIcon()
    {
      super();
    }
    /**
     * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
     */
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      element = newIconSVG("") as WrappedHTMLElement;
      return element;
    }
  }
}