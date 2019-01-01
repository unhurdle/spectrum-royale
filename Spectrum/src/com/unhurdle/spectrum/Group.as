package com.unhurdle.spectrum
{
  import org.apache.royale.html.Group;
  import org.apache.royale.core.CSSClassList;

  public class Group extends org.apache.royale.html.Group
  {
    public function Group()
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