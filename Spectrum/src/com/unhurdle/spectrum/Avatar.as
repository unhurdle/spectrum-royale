package com.unhurdle.spectrum
{

  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class Avatar extends SpectrumBase
  {
    public function Avatar()
    {    
      super(); 
    }

    override protected function getSelector():String{
      return "spectrum-Avatar";
    }

    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
      return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      toggle("is-disabled",value);
      _disabled = value;
    }

    public function get src():String
    {
        return (element as HTMLImageElement).src;
    }
    
    public function set src(value:String):void
    {
      (element as HTMLImageElement).src = value;
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'img');
      return element;
    }

}
}