package com.unhurdle.spectrum
{
  public class Asset extends SpectrumBase
  {
    public function Asset()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Asset";
    }
  }
}