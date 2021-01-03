package com.unhurdle.spectrum.colorpicker
{

	COMPILE::JS
	{
		import org.apache.royale.core.WrappedHTMLElement;
	}
	import com.unhurdle.spectrum.SpectrumBase;
	import com.unhurdle.spectrum.ColorSwatch;
	import org.apache.royale.core.ValuesManager;
	import org.apache.royale.events.MouseEvent;
	import com.unhurdle.spectrum.interfaces.IRGBA;
	import com.unhurdle.spectrum.data.RGBColor;
	import com.unhurdle.spectrum.interfaces.IColorPopover;

	public class ColorPicker extends SpectrumBase
	{

		public function ColorPicker()
		{
		}

		private var _position:String = "bottom";

		public function get position():String
		{
			return _position;
		}

		public function set position(value:String):void
		{
			_position = value;
		}
		private var _color:uint;

		public function get color():uint{
			var c:IRGBA = appliedColor;
			if(!c){
				return 0;
			}
			var r:uint = c.r & 0xFF;
			var g:uint = c.g & 0xFF;
			var b:uint = c.b & 0xFF;
			if(c.alpha){
				var a:uint = c.alpha & 0xFF;
				return (a << 24) | (r << 16) | (g << 8) | (b << 0);
			}
			return (r << 16) | (g << 8) | (b << 0);
		}

		public function set color(value:uint):void{
			var a:uint = value >> 24 & 255;
			var r:uint = value >> 16 & 255;
			var g:uint = value >> 8 & 255;
			var b:uint = value >> 0 & 255;
			appliedColor = new RGBColor([r,g,b,a]);
		}
		
		private var _button:ColorSwatch;
		public function get appliedColor():IRGBA{
			return _button.color;
		}

		public function set appliedColor(value:IRGBA):void{
			_button.color = value;
			popover.appliedColor = value;
		}

		public function get dataProvider():Object{
			return popover.dataProvider;
		}
		public function set dataProvider(value:Object):void{
			popover.dataProvider = value;
		}

		public function get applyText():String{
			return popover.applyText;
		}
		public function set applyText(value:String):void{
			popover.applyText = value;
		}

		public function get cancelText():String{
			return popover.cancelText;
		}
		public function set cancelText(value:String):void{
			popover.cancelText = value;
		}

		public function get showApplyButtons():Boolean{
			return popover.showApplyButtons;
		}
		public function set showApplyButtons(value:Boolean):void{
			popover.showApplyButtons = value;
		}

		public function get showColorControls():Boolean{
			return popover.showColorControls;
		}
		public function set showColorControls(value:Boolean):void{
			popover.showColorControls = value;
		}

		public function get showAlphaControls():Boolean{
			return popover.showAlphaControls;
		}
		public function set showAlphaControls(value:Boolean):void{
			popover.showAlphaControls = value;
		}

		public function get showSelectionSwatch():Boolean{
			return popover.showSelectionSwatch;
		}
		public function set showSelectionSwatch(value:Boolean):void{
			popover.showSelectionSwatch = value;
		}
		
		public function get areaSize():Number{
			return popover.areaSize;
		}
		public function set areaSize(value:Number):void{
			popover.areaSize = value;
		}
		
		private function createButton():ColorSwatch{
			var button:ColorSwatch = new ColorSwatch();
			button.size = 24;
			button.setStyle("cursor","pointer");
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
		private var _popover:IColorPopover;

		public function set popover(value:IColorPopover):void
		{
			_popover = value;
		}

		public function get popover():IColorPopover{
			if(!_popover){            
				var c:Class = ValuesManager.valuesImpl.getValue(this, "iPopup") as Class;
				if(c){
					_popover = new c() as IColorPopover;
				}
			}
			return _popover;
		}
		protected function togglePopover(ev:Event):void{
			ev.preventDefault();
			var open:Boolean = !popover.open;
			if(open){
				// dispatchEvent(new Event("showMenu"));
				COMPILE::JS
				{
					requestAnimationFrame(openPopup);
				}
			} else {
				closePopup();
			}
		}

		protected function openPopup():void{
			popover.open = true;
			_button.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			popover.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
		}
		protected function closePopup():void{
			if(popover && popover.open){
				popover.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				_button.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
				popover.open = false;
			}
		}
		protected function handleControlMouseDown(event:MouseEvent):void{
			event.stopImmediatePropagation();
		}
		protected function handleTopMostEventDispatcherMouseDown(event:MouseEvent):void{
			closePopup();
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