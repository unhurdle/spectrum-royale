package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.TextBase;
  

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