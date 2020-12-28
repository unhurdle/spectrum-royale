package com.unhurdle.spectrum.colorpicker
{

	COMPILE::JS
	{
		import org.apache.royale.core.WrappedHTMLElement;
		import com.unhurdle.spectrum.newElement;
	}
	import com.unhurdle.spectrum.SpectrumBase;
	import org.apache.royale.html.elements.Div;

	public class ColorPicker extends SpectrumBase
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

		public function ColorPicker()
		{
		}
		private var _button:Div;
		private var buttonBackground:CSSStyleDeclaration;
		private function setButtonColor(r:Number,b:Number,g:Number,alpha:Number):void{
			COMPILE::JS
			{
				buttonBackground.backgroundColor = "rgba(" + r + ", " + g + ", " + b + ", " + alpha + ")";
			}
		}
		private function createButton():Div{
			var button:Div = new Div();
			button.width = 24;
			button.height = 24;
			var div1:HTMLElement = newElement("div","spectrum-ColorSlider-checkerboard");
			div1.setAttribute("role","presentation");
			var div2:HTMLElement = newElement("div","spectrum-ColorSlider-gradient");
			div2.setAttribute("role","presentation");
			buttonBackground = div2.style;
			div1.appendChild(div2);
			button.element.appendChild(div1);
			button.addEventListener("click",togglePopover);
			return button;
		}
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			_button = createButton();
			addElement(_button);
			// popover = new ComboBoxList();
			// popover.className = appendSelector("-popover");
			// popover.addEventListener("openChanged",handlePopoverChange);
			// // popover.percentWidth = 100;
			// // popover.style = {"z-index":100};//????
			// // menu = new Menu();
			// // popover.addElement(menu);
			// menu.addEventListener("change", handleListChange);
			// menu.percentWidth = 100;
			// popover.style = {"z-index": "2"};
			return elem;
		}
		protected function togglePopover(ev:Event):void{
			ev.preventDefault();
			var open:Boolean = !popover.open;
			toggle("is-open",open);
			if(open){
				positionPopup();
				// dispatchEvent(new Event("showMenu"));
				COMPILE::JS
				{
					requestAnimationFrame(openPopup);
				}
			} else {
				closePopup();
			}

		}
	}

}
/**
 * Options:
 * Selection Closes -- Could be dependent on Apply and Cancel buttons.
 * Only swatches
 * Opacity slider
 * Hex value editable
 * Apply Button (set via label)
 * Cancel button (ditto)
 * Compare old/new values
 * 
 */
/**
 * Notes:
 * Use Color Sliders
 * Use Color Slider styling for swatches
 * Ditto for main swatch
 * Sample color swatch seems to not have rounded corners in Adobe's design and it's 32px instead of 24.
 */