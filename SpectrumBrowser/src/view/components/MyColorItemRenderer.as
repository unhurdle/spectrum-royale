package view.components
{
	import org.apache.royale.utils.CSSUtils;
	import org.apache.royale.html.supportClasses.DataItemRenderer;
	import org.apache.royale.html.elements.Div;

	public class MyColorItemRenderer extends DataItemRenderer
	{
		public function MyColorItemRenderer()
		{
			super();
            typeNames = 'MyColorItemRenderer';
		}

		override public function set data(value:Object):void
		{
			super.data = value;
			updateRenderer();
		}

		override public function updateRenderer():void
		{
            var color:uint;
            if (!isNaN(data))
            {
                color = uint(data);
            } else if (dataField)
            {
                color = uint(data[dataField]);
            } else
            {
                color = 0x000000;
            }
            innerElement.element.style.backgroundColor = CSSUtils.attributeFromColor(color);
		}

        private var innerElement:Div;
        private var padding:Number = 2;
        override public function addedToParent():void
        {
            super.addedToParent();
            if (!innerElement)
            {
                innerElement = new Div();
                innerElement.width = width - 2 * padding;
                innerElement.height = height - 2 * padding;
                element.style.padding = padding + "px";
                addElement(innerElement);
            }
        }

        override public function set height(value:Number):void
        {
            super.height = value;
            if (innerElement)
            {
                innerElement.height = value - 2 * padding;
            }
        }

        override public function set width(value:Number):void
        {
            super.width = value;
            if (innerElement)
            {
                innerElement.width = value - 2 * padding;
            }
        }

	}
}
