package com.unhurdle.spectrum
{
  import org.apache.royale.core.UIBase;
  import org.apache.royale.core.CSSClassList;
  COMPILE::JS
  {
  import org.apache.royale.html.util.addElementToWrapper;
  import org.apache.royale.core.WrappedHTMLElement;
  }

  public class SpectrumBase extends UIBase
  {
    public function SpectrumBase()
    {
      super();
      classList = new CSSClassList();
      typeNames = getSelector();
    }

    protected function getSelector():String{
      return "";
    }
    protected function appendSelector(value:String):String{
      return getSelector() + value;
    }

    protected var classList:CSSClassList;

    protected function toggle(classNameVal:String,add:Boolean):void
    {
      COMPILE::JS
      {
        add ? classList.add(classNameVal) : classList.remove(classNameVal);
        setClassName(computeFinalClassNames());
      }
    }
    
    COMPILE::JS
    override protected function computeFinalClassNames():String
    { 
      return (classList.compute() + super.computeFinalClassNames()).trim();
    }
    
    protected function valueToSelector(value:String):String{
      return getSelector() + "--" + value;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,'div');
    }

    private var _flexGrow:int = -1;

    public function get flexGrow():int
    {
    	return _flexGrow;
    }

    public function set flexGrow(value:int):void
    {
    	_flexGrow = value;
      COMPILE::JS
      {
        if(value < 0){
          element.style.removeProperty("flex-grow");
        } else {
          element.style.flexGrow = value;
        }

      }
    }

  }
}