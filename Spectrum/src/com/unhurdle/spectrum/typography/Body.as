package com.unhurdle.spectrum.typography
{
  public class Body extends Typography
  {
    public function Body()
    {
      super();
    }
    override protected function getTypographySelector():String{
      return "spectrum-Body";
    }
    override protected function getSizes():Array{
      return[
        "XS",
        "S",
        "M",
        "L",
        "XL",
        "XXL",
        "XXXL"
      ];
    }
    /**
     * override to set the correct enumerations
     */
    [Inspectable(category="General", enumeration="XS,S,M,L,XL,XXL,XXXL", defaultValue="L")]
    override public function set size(value:String):void{
      super.size = value;
    }
  }
}