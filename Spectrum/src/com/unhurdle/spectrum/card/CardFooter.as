package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.TextBase;
  import com.unhurdle.spectrum.Group;

  public class CardFooter extends TextBase
  {
    public function CardFooter()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-footer";
    }
  }
}