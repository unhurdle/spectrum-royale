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
	[Event(name="input", type="org.apache.royale.events.Event")]
	public class Search extends SpectrumBase implements ITextContent
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
		protected var _input:TextField;
		protected var button:ClearButton;

		public function get input():TextField
		{
			return _input;
		}

		public function get text():String
		{
			return _input.text;
		}

		public function set text(value:String):void
		{
			_input.text = value;
		}

		private var _quiet:Boolean; 

		public function get quiet():Boolean
		{
			return _quiet;
		}

		public function set quiet(value:Boolean):void
		{
			if(_quiet != value){
				_input.quiet = value;
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
				_input.disabled = value;
				button.disabled = value;
			}
			_disabled = value;
		}

		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
		super.createElement();
		_input = new TextField();
		// percentWidth needed to allow the container copmponent to be sized
		_input.percentWidth = 100;
		(_input.element as HTMLInputElement).type = "search";
		_input.placeholder = "Search";
		//TODO forward events
		addElement(_input);
		var type:String = IconType.MAGNIFIER;
		_input.icon = IconPrefix.SPECTRUM_CSS_ICON + type;
		_input.iconType = type;

		_input.input.style.paddingRight = "25px";
		button = new ClearButton();
		button.className = appendSelector("-clearButton");
		button.addEventListener("clear" , clear);
		_input.addElement(button);
		_input.input.addEventListener("input", function(ev:Event):void{
			dispatchEvent(new Event("input"));
		});
		_input.addEventListener("onEnter", dispatchSearch);
		//TODO: Do we want to search on tab?
		_input.addEventListener("onTab", function(ev:Event):void{
			dispatchEvent(new Event("search"));
		});

		// element.addEventListener("submit", handleSubmit);
		return element; 
		}
		protected function dispatchSearch(ev:Event):void{
			dispatchEvent(new Event("search"));
		}
		protected function clear(ev:Event):void{
			_input.text = "";
			dispatchEvent(new Event("search"));
		}
		// protected function handleSubmit(ev:Event):Boolean{
		// 	ev.preventDefault();
		// 	dispatchEvent(new Event("search"));
		// 	return false;
		// }
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
			return _input.placeholder;
		}

		public function set placeholder(value:String):void
		{
			_input.placeholder = value;
		}

	}
}