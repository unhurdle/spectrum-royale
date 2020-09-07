package com.unhurdle.spectrum.typography
{

  public class Display extends Heading
  {
    public function Display()
    {
      super();
    }

    override protected function getSelector():String{
      return getTypographySelector() + "--display " + getTypographySelector();
    }
  }
}