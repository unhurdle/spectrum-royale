package com.unhurdle.spectrum.renderers
{
	COMPILE::JS
		{
			import org.apache.royale.core.WrappedHTMLElement;
		
		}

	public class TableItemRenderer extends ListItemRendererForTable
	{
		
		public function TableItemRenderer()
		{
			super();
			typeNames = "spectrum-Table-cell";
			
		}
		
		override protected function getTag():String{
			return "td";
		}
			
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
			var elem:WrappedHTMLElement = super.createElement();
			elem.tabIndex = 0;
			return elem;
		}
	}
	}
