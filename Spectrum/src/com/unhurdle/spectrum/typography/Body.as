package com.unhurdle.spectrum.typography
{
  public class Body extends Typography
  {
    public function Body()
    {
      super();
      _size = 1;
    }
    override protected function getTypographySelector():String{
      return "spectrum-Body";
    }

  }
}