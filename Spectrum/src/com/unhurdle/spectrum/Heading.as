package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class Heading extends Typography
  {
    public function Heading()
    {
      super();
    }
    override protected function getTypographySelector():String{
      return "spectrum-Heading";
    }

  }
}