package com.unhurdle.spectrum
{
	COMPILE::JS{
		import org.apache.royale.core.WrappedHTMLElement;
	}

	public class Radio extends SpectrumBase implements ITextContent
	{
	/**
	 * <inject_html>
	 * <link rel="stylesheet" href="assets/css/components/radio/dist.css">
	 * </inject_html>
	 *
	 */
		public function Radio()
		{
			super();
		}
		override protected function getSelector():String{
			return "spectrum-Radio";
		}
		private var input:HTMLInputElement;

		private var label:TextNode;


		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			input = newElement("input",appendSelector("-input")) as HTMLInputElement;
			input.type = "radio";
			elem.appendChild(input);
			elem.appendChild(newElement("span",appendSelector("-button")));
			label = new TextNode("label");
			label.className = appendSelector("-label");
			elem.appendChild(label.element);
			return elem;
		}


		public function get checked():Boolean
		{
			return !!input.checked ;
		}

		public function set checked(value:Boolean):void
		{
			if(value != !!input.checked){
				input.checked = value;
			}
		}
		private var _labelBelow:Boolean;

		public function get labelBelow():Boolean
		{
			return _labelBelow;
		}

		public function set labelBelow(value:Boolean):void
		{
			if(value != !!_labelBelow){
				toggle(valueToSelector("labelBelow"),value);
			}
			_labelBelow = value;
		}


		public function get disabled():Boolean
		{
			return !!input.disabled;
		}

		public function set disabled(value:Boolean):void
		{
			if(value != !!input.disabled){
				input.disabled = value;
			}
		}
		private var _invalid:Boolean;
		public function get invalid():Boolean
		{
			return _invalid;
		}
		public function set invalid(value:Boolean):void
		{
			if(value != !!_invalid){
				toggle("is-invalid",value);
			}
			_invalid = value;
		}
		private var _text:String;
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value
			label.text = value;
		}

		private var _quiet:String;
		public function get quiet():String
		{
			return _quiet;
		}

		public function set quiet(value:String):void
		{
			if(_quiet != value){
				toggle(valueToSelector("quiet"),value);
			}
			_quiet = value
		}
		public function get radioName():String
		{
			return input.name;
		}

		public function set radioName(value:String):void
		{
			input.name = value;
		}
	}
}
