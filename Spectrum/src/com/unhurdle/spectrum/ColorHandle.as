package com.unhurdle.spectrum
{
	COMPILE::JS{
			import org.apache.royale.core.WrappedHTMLElement;
	}
	import org.apache.royale.events.ValueEvent;
	import com.unhurdle.spectrum.data.RGBColor;
	import com.unhurdle.spectrum.interfaces.IRGBA;

	[Event(name="colorChanged", type="org.apache.royale.events.ValueEvent")]
	public class ColorHandle extends SpectrumBase
	{
		public function ColorHandle(){
			super();
			appliedColor = new RGBColor([255,0,0]);
		}

		override protected function getSelector():String{
			return "spectrum-ColorHandle";
		}
			
		private var colorLoupe:ColorLoupe;
		private var colorDiv:HTMLElement;

		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			elem.style.position = "absolute";
			colorDiv = newElement("div",appendSelector("-color"));
			elem.appendChild(colorDiv);
			return elem;
		}
		private var _appliedColor:IRGBA;

		public function get appliedColor():IRGBA
		{
			return _appliedColor;
		}

		public function set appliedColor(value:IRGBA):void
		{
			if(value && backgroundStyleColor != value.styleString){
				_appliedColor = value;
				setBackgroundStyleColor(value.styleString);
				dispatchEvent(new ValueEvent("colorChanged",value));
			}
		}

		public function get backgroundStyleColor():String{
			return appliedColor ? appliedColor.styleString : "";
		}
		protected function setBackgroundStyleColor(value:String):void{
			colorDiv.style.backgroundColor = value;
		}

		private var _disabled:Boolean = false;

		public function get disabled():Boolean{
			return _disabled;
		}

		public function set disabled(value:Boolean):void{
			if(value != _disabled){
				_disabled = value;
				toggle("is-disabled",value);
			}
		}
			
		private var _open:Boolean = false;

		public function get open():Boolean{
			return _open;
		}

		public function set open(value:Boolean):void{
			if(value != _open){
				_open = value;
				if(value){
					//TODO ColorLoupe should only be used on touch interfaces
					if(!colorLoupe){
						colorLoupe = new ColorLoupe();
						colorLoupe.open = true;
						addElement(colorLoupe);
					}
				}else{
					if(colorLoupe){
						removeElement(colorLoupe);
						colorLoupe = null;
					}
				}
			}
		}
	}
}