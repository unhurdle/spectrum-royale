package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.Group;

  /**
   * Meant to be used inside CardBody. Has less space than CardHeader.
   */
  public class CardContent extends Group
  {
    public function CardContent()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-content";
    }
  }
}