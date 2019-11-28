package com.unhurdle.spectrum
{
  COMPILE::JS{
      import org.apache.royale.core.WrappedHTMLElement;
      import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.html.List;

  public class Accordion extends org.apache.royale.html.List
  {
    public function Accordion()
    {
      super();
      typeNames = getSelector();
    }
    
    private function getSelector():String{
      return "spectrum-Accordion";
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      return elem;
    }
  }
}