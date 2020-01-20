package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconType;

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