package com.unhurdle.spectrum.typography
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class Body extends Typography
  {
    public function Body()
    {
      super();
    }
    override protected function getTypographySelector():String{
      return "spectrum-Body";
    }

  }
}