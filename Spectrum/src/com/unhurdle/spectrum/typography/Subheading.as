package com.unhurdle.spectrum.typography
{
  /**
   * Subheading
   * Visually equivalent to Subtitle3
   */
  public class Subheading extends TypographyBase
  {
    public function Subheading()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Subheading";
    }
  }
}