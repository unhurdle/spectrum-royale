package com.unhurdle.spectrum
{
  public class DialogFooter extends Group
  {
    public function DialogFooter()
    {
      super();
      tabFocusable = false;
    }
    override protected function getSelector():String{
      return "spectrum-Dialog-footer";
    }
  }
}