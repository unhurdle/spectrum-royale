package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.TextBase;

  public class CardDescription extends TextBase
  {
    public function CardDescription()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-description";
    }
  }
}