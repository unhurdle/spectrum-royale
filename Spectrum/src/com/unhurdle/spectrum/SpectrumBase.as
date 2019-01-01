package com.unhurdle.spectrum
{
  import org.apache.royale.core.UIBase;
  import org.apache.royale.core.CSSClassList;

  public class SpectrumBase extends UIBase
  {
    public function SpectrumBase()
    {
      super();
      COMPILE::JS
      {
        classList = new CSSClassList();
      }
      
    }
    
    COMPILE::JS
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

  }
}