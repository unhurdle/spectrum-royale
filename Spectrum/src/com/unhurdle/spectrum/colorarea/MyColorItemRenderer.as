package com.unhurdle.spectrum.colorarea
{
	import org.apache.royale.utils.CSSUtils;
	import org.apache.royale.html.supportClasses.DataItemRenderer;
	import org.apache.royale.html.elements.Div;
	    import org.apache.royale.core.HTMLElementWrapper; 

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
            if (data is ColorWithAlphaModel)
            {
                color = (data as ColorWithAlphaModel).color;
                alpha = (data as ColorWithAlphaModel).alpha;
            } else
            {
                color = 0x000000;
                alpha = 1;
            }
			var r:uint = (color >> 16 ) & 255;
			var g:uint = (color >> 8 ) & 255;
			var b:uint = color & 255;
            var str:String = "rgba(" + r + ", " + g + ", " + b + ", " + alpha + ")";
            (innerElement.element as HTMLElementWrapper).style.backgroundColor = str;
		}

        private var innerElement:Div;
        private var padding:Number = 2;
        override public function addedToParent():void
        {
            super.addedToParent();
            if (!innerElement)
            {
                var innerBg:Div = new Div();
                innerBg.className = "CheckeredBackground";
                innerElement = new Div();
                innerBg.width = innerElement.width = width - 2 * padding;
                innerBg.height = innerElement.height = height - 2 * padding;
                (element as HTMLElementWrapper).style.padding = padding + "px";
                innerBg.addElement(innerElement);
                addElement(innerBg);
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
