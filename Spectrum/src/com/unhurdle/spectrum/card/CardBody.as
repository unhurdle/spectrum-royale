package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.Group;

  public class CardBody extends Group
  {
    public function CardBody()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-body";
    }
  }
}