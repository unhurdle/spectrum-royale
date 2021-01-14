package com.unhurdle.spectrum
{

	COMPILE::JS
	{
		import org.apache.royale.core.WrappedHTMLElement;
	}

	import com.unhurdle.spectrum.const.IconPrefix;
	import com.unhurdle.spectrum.const.IconType;
	import org.apache.royale.events.Event;

	[Event(name="search", type="org.apache.royale.events.Event")]
	public class Search extends SpectrumBase
	{
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/search/dist.css">
		 * </inject_html>
		 * 
		 */
		public function Search(){
			super();
		}
		override protected function getSelector():String{
			return "spectrum-Search";
		}
		protected var input:TextField;
		protected var button:ClearButton;

		public function get text():String
		{
			return input.text;
		}

		public function set text(value:String):void
		{
			input.text = value;
		}

		private var _quiet:Boolean; 

		public function get quiet():Boolean
		{
			return _quiet;
		}

		public function set quiet(value:Boolean):void
		{
			if(_quiet != value){
				input.quiet = value;
			}
			_quiet = value;
		}

		private var _disabled:Boolean;

		public function get disabled():Boolean
		{
			return _disabled;
		}

		public function set disabled(value:Boolean):void
		{
			if(value != !!_disabled){
				input.disabled = value;
				button.disabled = value;
			}
			_disabled = value;
		}

		override protected function getTag():String{
			return "form";
		}

		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
		super.createElement();
		input = new TextField();
		// percentWidth needed to allow the container copmponent to be sized
		input.percentWidth = 100;
		(input.element as HTMLInputElement).type = "search";
		input.placeholder = "Search";
		//TODO forward events
		addElement(input);
		var type:String = IconType.MAGNIFIER;
		input.icon = IconPrefix.SPECTRUM_CSS_ICON + type;
		input.iconType = type;

		input.input.style.paddingRight = "25px";
		button = new ClearButton();
		button.className = appendSelector("-clearButton");
		button.addEventListener("clear" , clear);
		input.addElement(button);
		element.addEventListener("submit", handleSubmit);
		return element; 
		}
		private function clear(ev:Event):void
		{
			input.text = "";
			dispatchEvent(new Event("search"));
		}
		protected function handleSubmit(ev:Event):Boolean{
			ev.preventDefault();
			dispatchEvent(new Event("search"));
			return false;
		}
		// COMPILE::JS
		// public function set searchIcon(value:Boolean):void
		// {
		//   if(!value){
		//     removeElement(inputIcon);
		//     input.className = "";
		//   }
		// }

		public function get placeholder():String
		{
			return input.placeholder;
		}

		public function set placeholder(value:String):void
		{
			input.placeholder = value;
		}

	}
}