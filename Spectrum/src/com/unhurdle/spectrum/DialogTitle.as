package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  public class DialogTitle extends TextGroup
  {
    public function DialogTitle()
    {
      super();
      tabFocusable = false;
    }
    override protected function getSelector():String{
      return "spectrum-Dialog-title";
    }

    override protected function getTag():String{
      return "h2";
    }

  }
}