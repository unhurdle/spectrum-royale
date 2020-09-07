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
    override public function validateSize(value:String):Boolean{
      switch(value){
        case "XS":
        case "S":
        case "M":
        case "L":
        case "XL":
        case "XXL":
        case "XXXL":
          return true;
        default:
          return false;
      }
    }
  }
}