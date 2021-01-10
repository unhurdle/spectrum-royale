package com.unhurdle.spectrum
{
	/**
	 * SwatchList is a list for showing color swatches usually in a color picker as tiles.
	 */
	public class SwatchList extends List
	{
		public function SwatchList()
		{
			super();
		}
		override protected function getSelector():String{
			return "";
		}
		private var _columnGap:Number;

		public function get columnGap():Number
		{
			return _columnGap;
		}

		public function set columnGap(value:Number):void
		{
			_columnGap = value;
		}
		private var _rowGap:Number;

		public function get rowGap():Number
		{
			return _rowGap;
		}

		public function set rowGap(value:Number):void
		{
			_rowGap = value;
		}
    override protected function getTag():String{
      return "div";
    }

	}
}