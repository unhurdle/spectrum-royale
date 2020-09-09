package com.unhurdle.spectrum
{

  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class DivTableHeaderCell extends TableHeaderCell
  {
   
    public function DivTableHeaderCell()
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
			elem.style.flex = "1";
			elem.setAttribute("role","columnheader");
      return elem;
		}
  }
}