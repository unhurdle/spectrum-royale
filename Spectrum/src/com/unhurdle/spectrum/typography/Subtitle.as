package com.unhurdle.spectrum.typography
{
  /**
   * Subtitle can be size 1 through 3.
   * Size 1 is equivalent to Heading4
   * Size 2 is equivalent to Heading6
   * Size 3 is equivalent to Subheading
   */
  public class Subtitle extends Heading
  {
    public function Subtitle()
    {
      super();
    }
    override protected function getSelector():String{
      return getTypographySelector() + "--subtitle" + size;
    }

    override protected function getMax():int{
      return 3;
    }

  }
}