package com.unhurdle.spectrum
{
  COMPILE::JS{}
  
	[Deprecated(message="Use ActionButton instead")]
  public class Tool extends ActionButton
  {
    //TODO the CSS for this exists in Button. We might need to create ButtonBase to import the CSS
    // Also, there is no handling of click and hold to show a menu.
    public function Tool()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Tool";
    }
  }
}