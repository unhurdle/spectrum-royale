package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.Group;

  /**
   * The body element of a Card.
   */
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