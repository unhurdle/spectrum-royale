package com.unhurdle.spectrum
{
  COMPILE::JS{
		import org.apache.royale.core.WrappedHTMLElement;
	}

  public class DivTableRow extends TableRow
  {
    public function DivTableRow()
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
		elem.style.display = "flex";
		elem.setAttribute("role","row");
		return elem;
	}
	private var _isDropTarget:Boolean;

	public function get isDropTarget():Boolean
	{
		return _isDropTarget;
	}

	public function set isDropTarget(value:Boolean):void
	{
		if(value != _isDropTarget){
			toggle("is-drop-target",value);
		}
		_isDropTarget = value;
	}
  }
}