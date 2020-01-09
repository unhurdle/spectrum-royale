package com.unhurdle.spectrum
{

  public class Accordion extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/accordion/dist.css">
     * </inject_html>
     * 
     */

    public function Accordion()
    {
      super();
    }

    override protected function getSelector():String{
      return "spectrum-Accordion";
    }

  }
}