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
			
		
		}

		private var _expandColumns:Number = 1;
    
		public function get expandColumns():Number
		{
      return _expandColumns;
		}
		public function set expandColumns(value:Number):void
		{
			if(_expandColumns != value)
			{
        _expandColumns = value;

				COMPILE::JS
				{
					element.setAttribute('colspan', _expandColumns);
				}
			}
		}
		
		private var _expandRows:Number = 1;
 
		public function get expandRows():Number
		{
      return _expandRows;
		}
		public function set expandRows(value:Number):void
		{
			if(_expandRows != value)
			{
        _expandRows = value;

				COMPILE::JS
				{
					element.setAttribute('rowspan', _expandRows);
				}
			}
		}

		COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
			var elem:WrappedHTMLElement = addElementToWrapper(this,'td');
			elem.className = "spectrum-Table-cell"; 
			return elem
		}
	}
}

    

