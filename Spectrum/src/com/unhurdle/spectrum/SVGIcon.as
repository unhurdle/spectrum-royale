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
      var elem:SVGElement = newSVGElement("svg","");
      elem.setAttribute("focusable", false);
      elem.setAttribute("aria-hidden",true);
      element = elem as WrappedHTMLElement;
      return element;
    }
  }
}