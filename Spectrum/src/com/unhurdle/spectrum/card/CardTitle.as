package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.TextBase;

  public class CardTitle extends TextBase
  {
    public function CardTitle()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-title";
    }
  }
}