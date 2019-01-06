package com.unhurdle.spectrum
{
  public class TagGroup extends Group
  {
    public function TagGroup()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Tags";
    }
  }
}