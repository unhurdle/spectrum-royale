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
      return classList.compute() + super.computeFinalClassNames();
    }
    
    protected function valueToSelector(value:String):String{
      return getSelector() + "--" + value;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,'div');
    }

  }
}