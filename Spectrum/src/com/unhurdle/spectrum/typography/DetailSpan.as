package com.unhurdle.spectrum.typography
{
  public class DetailSpan extends Detail
  {
    public function DetailSpan()
    {
      super();
    }
    override protected function getTag():String{
      return "span";
    }
  }
}