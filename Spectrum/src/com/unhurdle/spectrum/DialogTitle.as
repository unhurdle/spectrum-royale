package com.unhurdle.spectrum
{
  public class DialogTitle extends TextGroup
  {
    public function DialogTitle()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Dialog-title";
    }

    override protected function getTag():String{
      return "h2";
    }

  }
}