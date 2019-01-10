package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.TextBase;

  public class CardSubtitle extends TextBase
  {
    public function CardSubtitle()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-subtitle";
    }
  }
}