package com.unhurdle.spectrum
{

  public class Well extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/well/dist.css">
     * </inject_html>
     * 
     */
    public function Well()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Well";
    }
    override protected function getTag():String{
      return "span";
    }
  }
}