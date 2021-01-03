package com.unhurdle.spectrum.typography
{
  import com.unhurdle.spectrum.TypographyGroup;

  public class TypographyBase extends TypographyGroup
  {
    public function TypographyBase()
    {
      super();
    }

    override protected function getTag():String{
      return "p";
    }
  }
}