package com.unhurdle.spectrum
{
	/**
	 * A Divider element
	 * Use HDivider for horizontal or VDivider for vertical
	 */
	public class Divider extends SpectrumBase
	{
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/divider/dist.css">
		 * </inject_html>
		 * 
		 */
		public function Divider()
		{
			super();
			size = "medium";
		}
		override protected function getSelector():String{
			return "spectrum-Divider";
		}

		private var _vertical:Boolean;

		/**
		 * Whether horizontal or vertical divider
		 */
		public function get vertical():Boolean
		{
			return _vertical;
		}

		public function set vertical(value:Boolean):void
		{
			if(value != !!_vertical){
				toggle(valueToSelector("vertical"),value);
			}
			_vertical = value;
		}
	
		private var _size:String;
		/**
		 * The size of the Divider. Can be small, medium or large
		 */
		public function get size():String
		{
				return _size;
		}
		[Inspectable(category="General", enumeration="small,medium,large", defaultValue="medium")]
		public function set size(value:String):void
		{
			if(value != _size){
				switch (value){
					case "small":
					case "medium":
					case "large":
							break;
					default:
							throw new Error("Invalid size: " + value);
				}
				if(_size){
					toggle(valueToSelector(_size), false);
				}
				toggle(valueToSelector(value), true);
				_size = value;
			}
		}
	}
}