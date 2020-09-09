package com.unhurdle.spectrum
{

  COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		import org.apache.royale.core.WrappedHTMLElement;
		}
		
		
	
	public class TableCell extends TextGroup
	{
	
		public function TableCell()
		{
			super();
			typeNames = "spectrum-Table-cell";
		
		}

    COMPILE::JS
    private var elem:WrappedHTMLElement;
    COMPILE::SWF
    private var elem:Object;
    
		private var _colSpan:Number = 1;
		public function get colSpan():Number
		{
      return _colSpan;
		}
		public function set colSpan(value:Number):void
		{
			if(_colSpan != value)
			{
        _colSpan = value;

				setAttribute('colspan', _colSpan);
			}
		}
		
		private var _rowSpan:Number = 1;
 
		public function get rowSpan():Number
		{
      return _rowSpan;
		}
		public function set rowSpan(value:Number):void
		{
			if(_rowSpan != value)
			{
        _rowSpan = value;

				setAttribute('rowspan', _rowSpan);
			}
		}
		override protected function getTag():String{
			return "td";
		}
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
      elem = addElementToWrapper(this,'td');
      elem.className = "spectrum-Table-Cell";
      textNode = new TextNode("");
      textNode.element = elem;
      return elem;
		}
		public var checkbox:CheckBox
    private var _checkboxCell:Boolean;
  
    public function get checkboxCell():Boolean
    {
    	return _checkboxCell;
    }
    public function set checkboxCell(value:Boolean):void
    {
      if(value != _checkboxCell){
        if(value){
          checkbox = new CheckBox();
					checkbox.checked = false;
          addElement(checkbox);
          style="padding-top:8px;padding-bottom:8px;flex:none";
        }
        toggle("spectrum-Table-checkboxCell",value);
      }
      _checkboxCell = value;
    }
		private var _checked:Boolean
  
    public function get checked():Boolean
    {
    	return _checked;
    }
    public function set checked(value:Boolean):void
    {
      _checked = value;
			if(checkbox){
				checkbox.checked = value;
			}
    }

    private var _indeterminate:Boolean;

    public function get indeterminate():Boolean
    {
      return _indeterminate;
    }

    public function set indeterminate(value:Boolean):void
    {
        if(checkbox){
           checkbox.indeterminate = value;
        }
      _indeterminate = value;
    }
		private var _divider:Boolean

    public function get divider():Boolean
    {
    	return _divider;
    }
    public function set divider(value:Boolean):void
    {
			if(value != divider){
				toggle("spectrum-Table-cell--divider",value);
			}
      _divider = value;
    }
	}
}