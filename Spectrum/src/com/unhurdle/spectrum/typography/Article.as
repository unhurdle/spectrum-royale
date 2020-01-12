package com.unhurdle.spectrum.typography
{
  import com.unhurdle.spectrum.Group;

  public class Article extends Group
  {
    public function Article()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Article";
    }
  }
}