package com.unhurdle.spectrum
{
	public class Link extends TextGroup
	{
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/link/dist.css">
		 * </inject_html>
		 * 
		 */
		public function Link()
		{
			super();
		}
		override protected function getSelector():String{
			return "spectrum-Link";
		}
		override protected function getTag():String{
			return "a";
		}

		COMPILE::JS
		private function getAnchorElement():HTMLAnchorElement{
			return element as HTMLAnchorElement;
		}


		private var _overBackground:Boolean;

		public function get overBackground():Boolean
		{
			return _overBackground;
		}

		public function set overBackground(value:Boolean):void
		{
			if(value != !!_overBackground){
				toggle(valueToSelector("overBackground"),value);
			}
			_overBackground = value;
		}
		private var _disabled:Object;
		private var _href:String;

		public function get href():String
		{
			return _href;
		}

		public function set href(value:String):void
		{
			if(value != _href){
				if(value){
					_href = value;
				} else {
					_href = "#";
				}
				COMPILE::JS
				{
					getAnchorElement().href = _href;
				}
			}
		}

		public function get disabled():Object
		{
			return _disabled;
		}

		public function set disabled(value:Object):void
		{
			if(value != !!_disabled){
				toggle("is-disabled",value);
			}
			_disabled = value;
		}
		private var _quiet:Boolean;

		public function get quiet():Boolean
		{
			return _quiet;
		}

		public function set quiet(value:Boolean):void
		{
			if(_quiet != value){
				toggle(valueToSelector("quiet"),value);
			}
			_quiet = value;
		}
		private var _secondary:Boolean;

		public function get secondary():Boolean
		{
			return _secondary;
		}

		public function set secondary(value:Boolean):void
		{
			if(_secondary != value){
				toggle(valueToSelector("secondary"),value);
			}
			_secondary = value;
		}
	}
}