package view.components
{
	import org.apache.royale.html.supportClasses.ColorPalette;
	import org.apache.royale.html.beads.layouts.TileLayout;
	import org.apache.royale.utils.loadBeadFromValuesManager;

	public class MyColorPickerPopUpWithPalette extends MyColorPickerPopUp
	{
		protected var palette:ColorPalette;

		public function MyColorPickerPopUpWithPalette()
		{
			super();
			palette = new ColorPalette();
			palette.element.style.border = "none";
			var colorPaletteLayout:TileLayout = loadBeadFromValuesManager(TileLayout, "iBeadLayout", palette) as TileLayout;
			colorPaletteLayout.rowHeight = colorPaletteLayout.columnWidth = 20;
			COMPILE::JS 
			{
				palette.element.style.position = "absolute";
			}
		}

		override public function set model(value:Object):void
		{
			super.model = value;
			palette.model = value;
			if (getElementIndex(palette) < 0)
			{
				addElement(palette);
			}
		}

		override public function addedToParent():void
		{
			palette.width = colorSpectrum.width + hueSelector.width + alphaSelector.width + 2 * padding;
			palette.x = padding;
			fixedSizeContainer.x = 0;
			fixedSizeContainer.y = palette.height + padding * 2;
			height = fixedSizeContainer.y + fixedSizeContainer.height + padding;
			width = palette.width + padding * 2;
			super.addedToParent();
		}

	}
}