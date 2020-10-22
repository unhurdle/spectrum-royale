package com.unhurdle.spectrum
{
  public class DialogTypeIcon extends Group
  {
    public function DialogTypeIcon()
    {
      super();
      tabFocusable = false;
    }
    override protected function getSelector():String{
      return "spectrum-Dialog-typeIcon";
    }
  }
}