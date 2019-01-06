package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class Display extends Heading
  {
    public function Display()
    {
      super();
    }

    override protected function getSelector():String{
      return "spectrum-Heading1--display " + super.getSelector();
    }

  }
}