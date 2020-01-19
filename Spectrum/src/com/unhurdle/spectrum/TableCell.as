package com.unhurdle.spectrum
{

  COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		import org.apache.royale.core.WrappedHTMLElement;
		}
		
		
	
	public class TableCell extends Group
	{
	
		public function TableCell()
		{
			super();
			typeNames = "spectrum-Table-cell";
		
		}

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

		COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
			return addElementToWrapper(this,'td');
		}
	}
}

    

