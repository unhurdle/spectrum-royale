package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
    {
      import org.apache.royale.core.WrappedHTMLElement;
    	import org.apache.royale.html.util.addElementToWrapper;
    	import com.unhurdle.spectrum.TextNode;
    
    }

	public class TableItemRenderer extends ListItemRendererForTable
	{
		
		public function TableItemRenderer()
		{
			super();
			typeNames = "spectrum-Table-cell";
			
		}
		
      
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
          var elem:WrappedHTMLElement = addElementToWrapper(this,'td');
					elem.tabIndex = 0;
          if(MXMLDescriptor == null)
			    {
				  textNode = new TextNode('');
					textNode.element = element;
			    }

			
          return element;
        }
	}
  }
