package com.unhurdle.spectrum
{
  public class Asset extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/asset/dist.css">
     * </inject_html>
     * 
     */

    public function Asset()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Asset";
    }
  }
}