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
    COMPILE::JS
    private var avatar:WrappedHTMLElement;
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
      COMPILE::JS{
        return (element as HTMLImageElement).src;

      }
      COMPILE::SWF{
        return "";
      }
      
    }
    
    public function set src(value:String):void
    {
      // if(!value){
      
        COMPILE::JS{
          (element as HTMLImageElement).src = value;
        }
      // }
    	// _source = value;
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'img');
      return element;
    }

}
}