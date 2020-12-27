package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.utils.CSSUtils;
	import org.apache.royale.html.supportClasses.DataItemRenderer;
	import org.apache.royale.html.elements.Div;
	import org.apache.royale.core.HTMLElementWrapper;

	COMPILE::JS
	{
		import org.apache.royale.utils.html.getStyle;
	}
	import org.apache.royale.core.IColorWithAlphaModel;

	public class ColorItemRenderer extends DataItemRenderer
	{
		public function ColorItemRenderer()
		{
			super();
			typeNames = 'ColorItemRenderer';
		}

		override public function set data(value:Object):void
		{
			super.data = value;
			updateRenderer();
		}

		public function updateRenderer():void
		{
			var color:uint;
			if (data is IColorWithAlphaModel)
			{
				color = (data as IColorWithAlphaModel).color;
				alpha = (data as IColorWithAlphaModel).alpha;
			} else
			{
				color = 0x000000;
				alpha = 1;
			}
			var r:uint = (color >> 16 ) & 255;
			var g:uint = (color >> 8 ) & 255;
			var b:uint = color & 255;
			var str:String = "rgba(" + r + ", " + g + ", " + b + ", " + alpha + ")";
			COMPILE::JS
			{
				getStyle(innerElement).backgroundColor = str;
			}
		}

		private var innerElement:Div;
		private var innerBg:Div;
		private var padding:Number = 2;
		override public function addedToParent():void
		{
			super.addedToParent();
			if (!innerElement)
			{
				innerBg = new Div();
				COMPILE::JS
				{
					applyCheckeredBackground(innerBg.element.style);
				}
				// innerBg.className = "CheckeredBackground";
				innerElement = new Div();
				innerBg.width = innerElement.width = Math.max(0, width - 2 * padding);
				innerBg.height = innerElement.height = Math.max(0, height - 2 * padding);
				COMPILE::JS
				{
					getStyle(this).padding = padding + "px";
				}
				innerBg.addElement(innerElement);
				addElement(innerBg);
			}
		}

		override public function set height(value:Number):void
		{
			super.height = value;
			if (innerElement && innerBg)
			{
				innerBg.height = innerElement.height = Math.max(0, value - 2 * padding);
			}
		}

		override public function set width(value:Number):void
		{
			super.width = value;
			if (innerElement && innerBg)
			{
				innerBg.width = innerElement.width = Math.max(0, value - 2 * padding);
			}
		}

	}
}
