package com.unhurdle.spectrum
{

    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class DivTable extends Table
    {
    public function DivTable()
    {
        super();
    }

    override protected function getTag():String{
        return "div";
    }
    
    COMPILE::JS
    private var elem:WrappedHTMLElement;
    COMPILE::SWF
    private var elem:Object;
		
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
        elem = super.createElement();
        elem.setAttribute("role","grid");
        return elem;
    }
  }
}