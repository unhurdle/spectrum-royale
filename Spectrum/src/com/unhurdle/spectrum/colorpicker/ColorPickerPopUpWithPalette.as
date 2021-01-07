package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.html.supportClasses.ColorPalette;
	import org.apache.royale.html.beads.layouts.TileLayout;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.core.HTMLElementWrapper;
	
	COMPILE::JS
	{
		import org.apache.royale.utils.html.getStyle;
	}

	public class ColorPickerPopUpWithPalette extends ColorPickerPopUp
	{
		protected var palette:ColorPalette;

		public function ColorPickerPopUpWithPalette()
		{
			super();
			palette = new ColorPalette();
			COMPILE::JS
			{
				getStyle(palette).border = "none";
			}
			var colorPaletteLayout:TileLayout = loadBeadFromValuesManager(TileLayout, "iBeadLayout", palette) as TileLayout;
			colorPaletteLayout.rowHeight = colorPaletteLayout.columnWidth = 20;
			COMPILE::JS 
			{
				palette.element.style.position = "absolute";
			}
		}

		// override public function set model(value:Object):void
		// {
		// 	super.model = value;
		// 	palette.model = value;
		// 	if (getElementIndex(palette) < 0)
		// 	{
		// 		addElement(palette);
		// 	}
		// }

		// override protected function layout():void
		// {
		// 	var squareDim:Number = 225;
		// 	var sliderWidth:Number = 30;
		// 	colorSpectrum.height =  squareDim;
		// 	colorSpectrum.width =  squareDim;
		// 	colorSpectrum.y = padding;
		// 	colorSpectrum.x = padding;
		// 	hueSelector.width = sliderWidth;
		// 	hueSelector.height = squareDim;
		// 	hueSelector.x = colorSpectrum.x + colorSpectrum.width + padding;
    //         hueSelector.y = padding;
		// 	alphaSelector.width = sliderWidth;
		// 	alphaSelector.height = squareDim;
		// 	alphaSelector.x = hueSelector.x + sliderWidth + padding;
    //         alphaSelector.y = padding;
		// 	colorTextField.x = padding;
		// 	colorTextField.y = colorSpectrum.y + colorSpectrum.height + padding;
		// 	colorTextField.width = 132;
		// 	alphaTextField.x = colorTextField.width + colorTextField.x + padding;
		// 	alphaTextField.y = colorTextField.y;
		// 	alphaTextField.width = 66;
		// 	palette.width = colorSpectrum.width + hueSelector.width + alphaSelector.width + 2 * padding;
		// 	palette.x = padding;
		// 	fixedSizeContainer.width = alphaSelector.x + alphaSelector.width + padding;
		// 	fixedSizeContainer.height = colorTextField.y + 32 + padding;
		// 	fixedSizeContainer.x = 0;
		// 	fixedSizeContainer.y = palette.height + padding;
		// 	width = palette.width + padding * 2;
		// 	height = fixedSizeContainer.y + fixedSizeContainer.height + padding;
		// }

	}
}
