package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.Group;

  public class CardHeader extends Group
  {
    public function CardHeader()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-header";
    }
  }
}