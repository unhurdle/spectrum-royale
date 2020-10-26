package com.unhurdle.spectrum
{
  public class DialogContent extends TextGroup
  {
    public function DialogContent()
    {
      super();
      tabFocusable = false;
    }
    override protected function getSelector():String{
      return "spectrum-Dialog-content";
    }
  }
}