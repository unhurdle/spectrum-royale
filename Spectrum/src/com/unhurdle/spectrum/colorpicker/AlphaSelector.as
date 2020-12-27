package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.html.Slider;

	public class AlphaSelector extends Slider
	{
		public function AlphaSelector()
		{
			super();
			typeNames = "AlphaSelector";
			COMPILE::JS
			{
				applyCheckeredBackground(element.style);
			}
			minimum = 0;
			maximum = 100;
		}
	}
}
