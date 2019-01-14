package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.Group;

  /**
   * Meant to be used inside CardBody. Appropriate for header text which has spacing above.
   */
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