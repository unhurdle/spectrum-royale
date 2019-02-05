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
    private var _font:String;

    public function get font():String
    {
    	return _font;
    }

    public function set font(value:String):void
    {
      if(value != _font){
        switch (value){
        // check that values are valid
        case "small":
        case "large":
        case "secondary":
        case "italic":
            break;
        default:
            throw new Error("Invalid font: " + value);
        }
        var oldFont:String = valueToSelector(_font);
        var newFont:String = valueToSelector(value);
        toggle(newFont, true);
        toggle(oldFont, false);
        _font = value;
      }
    }
  }
}