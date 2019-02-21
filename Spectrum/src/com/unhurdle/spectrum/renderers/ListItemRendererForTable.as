package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.core.StyledMXMLItemRenderer;
	import org.apache.royale.events.Event;

	import org.apache.royale.html.util.getLabelFromData;
	

    COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		import com.unhurdle.spectrum.TextNode;
		
    }
	

	public class ListItemRendererForTable extends StyledMXMLItemRenderer 
	{
		// implements ITextItemRenderer
		public function ListItemRendererForTable()
		{
			super();

			typeNames = "spectrum-Table-cell";
			addClass("selectable");

			// textAlign = new TextAlign();
			// addBead(textAlign);
		}

		private var _text:String = "";

		public function get text():String
		{
            return _text;
		}

		public function set text(value:String):void
		{
            _text = value;
			
			COMPILE::JS
			{
			if(textNode != null)
			{
				textNode.text = _text;
			}	
			}
		}

		COMPILE::JS
    protected var textNode:TextNode;

		

		// private var textAlign:TextAlign;

		// public function get align():String
		// {
		// 	return textAlign.align;
		// }

		// public function set align(value:String):void
		// {
		// 	textAlign.align = value;
		// }

		
		override public function set data(value:Object):void
		{
			super.data = value;
            text = getLabelFromData(this, value);
			dispatchEvent(new Event("dataChange"));
		}

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
			addElementToWrapper(this, 'li');
            
			if(MXMLDescriptor == null)
			{
				textNode = new TextNode('');
				textNode.element = element;
			}
            return element;
        }

		private var _selectable:Boolean = true;
	
		override public function get selectable():Boolean
		{
			return _selectable;
		}
		override public function set selectable(value:Boolean):void
		{
			_selectable = value;
			toggleClass("selectable", _selectable);	
		}

		override public function updateRenderer():void
		{
			// if (down)
			// 	useColor = downColor;
			// else if (hovered)
			// 	useColor = highlightColor;
			// else 
            //if (selected)
            // 	useColor = selectedColor;
			//else
			// 	useColor = backgroundColor;

			if(hoverable)
            	toggleClass("hovered", hovered);
			if(selectable)
            	toggleClass("selected", selected);
		}
  }
}


