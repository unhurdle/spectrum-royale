package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.Group;

  public class CardActionButton extends Group
  {
    public function CardActionButton()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-actionButton";
    }
  }
}