package com.unhurdle.spectrum
{
	public class Table extends Group
	{
	/**
	 * <inject_html>
	 * <link rel="stylesheet" href="assets/css/components/table/dist.css">
	 * </inject_html>
	 * 
	 */
		public function Table()
		{
			super();
		}

		override protected function getSelector():String{
			return "spectrum-Table";
		}
		private var _fixedHeader:Boolean;
		public function get fixedHeader():Boolean{
			return _fixedHeader;
		}
		public function set fixedHeader(value:Boolean):void{
			_fixedHeader = value;
			toggle("fixedHeader", _fixedHeader);
		}
		private var _quiet:Boolean;
		public function get quiet():Boolean{
			return _quiet;
		}

		public function set quiet(value:Boolean):void{
			if(value != !!_quiet){
			toggle(valueToSelector("quiet"),value);
			}
			_quiet = value;
		}
		private var _multiSelect:Boolean;
		public function get multiSelect():Boolean{
			return _multiSelect;
		}
		public function set multiSelect(value:Boolean):void{
		
			_multiSelect = value;
		}
		override protected function getTag():String{
			return 'table';
		}

	}
}