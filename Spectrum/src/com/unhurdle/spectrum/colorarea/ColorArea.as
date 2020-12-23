package com.unhurdle.spectrum.colorarea
{

	import org.apache.royale.html.ColorPicker;

	public class ColorArea extends ColorPicker
	{
		private var _position:String = "bottom";

		public function get position():String
		{
			return _position;
		}

		public function set position(value:String):void
		{
			_position = value;
		}

		public function ColorArea()
		{
		}

	}
}
