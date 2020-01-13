package com.unhurdle.spectrum
{
  import org.apache.royale.html.elements.Div;

  public class Background extends Div
  {
    /**
     * Use this class for backgrounds behind "background elements" (such as Background Buttons).
     * Setting the color sets both the background color and the color value which
     * bleeds through to "background elements" which inherit the color.
     */
    public function Background()
    {
      
    }
    private var _color:String;

    public function get color():String
    {
    	return _color;
    }

    public function set color(value:String):void
    {
    	_color = value;
      COMPILE::JS
      {
        element.style.backgroundColor = value;
        element.style.color = value;
      }
    }
  }
}