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
	import org.apache.royale.utils.DisplayUtils;
	import com.unhurdle.spectrum.utils.getDataProviderItem;
	import org.apache.royale.events.ValueEvent;
	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.utils.getExplicitZIndex;

	[Event(name="colorChanged", type="org.apache.royale.events.ValueEvent")]
	[Event(name="colorCommit", type="org.apache.royale.events.ValueEvent")]
	[Event(name="cancel", type="org.apache.royale.events.Event")]
	[Event(name="openChanged", type="org.apache.royale.events.Event")]
	public class ColorPicker extends SpectrumBase
	{

		public function ColorPicker()
		{
			super();
		}

		private var _position:String = "bottom";
		public function get position():String{
			return _position;
		}
		[Inspectable(category="General", enumeration="bottom,top,right,left" defaultValue="bottom")]
		public function set position(value:String):void{
			_position = value;
		}

		public function get colorValue():uint{
			if(!appliedColor){
				return 0;
			}
			return appliedColor.colorValue;
		}

		public function set colorValue(value:uint):void{
			var color:RGBColor = new RGBColor();
			color.colorValue = value;
			appliedColor = color;
		}
		
		protected var button:ColorSwatch;
		public function get appliedColor():IRGBA{
			return button.color;
		}

		public function set appliedColor(value:IRGBA):void{
			button.color = value;
		}
		private var _dataProvider:Object;
		public function get dataProvider():Object{
			return _dataProvider;
		}
		public function set dataProvider(value:Object):void{
			_dataProvider = value;
		}
		private var _applyText:String = "Apply";
		public function get applyText():String{
			return _applyText;
		}
		public function set applyText(value:String):void{
			_applyText = value;
		}

		private var _cancelText:String = "Cancel";
		public function get cancelText():String{
			return _cancelText;
		}
		public function set cancelText(value:String):void{
			_cancelText = value;
		}

		private var _showApplyButtons:Boolean = true;
		public function get showApplyButtons():Boolean{
			return _showApplyButtons;
		}
		public function set showApplyButtons(value:Boolean):void{
			_showApplyButtons = value;
		}

		private var _showColorControls:Boolean = true;
		public function get showColorControls():Boolean{
			return _showColorControls;
		}
		public function set showColorControls(value:Boolean):void{
			_showColorControls = value;
		}

		private var _showAlphaControls:Boolean = true;
		public function get showAlphaControls():Boolean{
			return _showAlphaControls;
		}
		public function set showAlphaControls(value:Boolean):void{
			_showAlphaControls = value;
		}

		private var _showSelectionSwatch:Boolean = true;
		public function get showSelectionSwatch():Boolean{
			return _showSelectionSwatch;
		}
		public function set showSelectionSwatch(value:Boolean):void{
			_showSelectionSwatch = value;
		}
		/**
		 * technically the default be 192 and should be 240 on mobile, but we're setting it to 196 to fit the swatch list
		 */
		private var _areaSize:Number = 196;
		public function get areaSize():Number{
			return _areaSize;
		}
		public function set areaSize(value:Number):void{
			_areaSize = value;
		}
		
		private var _preferredColumns:int;
		public function get preferredColumns():int{
			return _preferredColumns;
		}

		public function set preferredColumns(value:int):void{
			_preferredColumns = value;
		}

		private var _preferredRows:int;
		public function get preferredRows():int{
			return _preferredRows;
		}

		public function set preferredRows(value:int):void{
			_preferredRows = value;
		}

		private var _hexEditable:Boolean = true;
		public function get hexEditable():Boolean{
			return _hexEditable;
		}

		public function set hexEditable(value:Boolean):void{
			_hexEditable = value;
		}

		protected function createButton():ColorSwatch{
			var button:ColorSwatch = new ColorSwatch();
			button.size = 24;
			button.setStyle("cursor","pointer");
			button.addEventListener("click",togglePopover);
			return button;
		}
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			button = createButton();
			addElement(button);
			// popover = new ComboBoxList();
			// popover.className = appendSelector("-popover");
			// popover.addEventListener("openChanged",handlePopoverChange);
			// // popover.percentWidth = 100;
			// // popover.setStyle("z-index",100);//????
			// // menu = new Menu();
			// // popover.addElement(menu);
			// menu.addEventListener("change", handleListChange);
			// menu.percentWidth = 100;
			// popover.setStyle("z-index", "2");
			return elem;
		}

		override public function addedToParent():void{
			if(!appliedColor && dataProvider){
				appliedColor = getDataProviderItem(dataProvider,0) as IRGBA;
			}
			super.addedToParent();
		}
		private var _popover:IColorPopover;

		public function set popover(value:IColorPopover):void
		{
			_popover = value;
		}

		public function get popover():IColorPopover{
			if(!_popover){            
				var c:Class = ValuesManager.valuesImpl.getValue(this, "iColorPopover") as Class;
				if(c){
					_popover = new c() as IColorPopover;
				}
				if(_popover){
					_popover.addEventListener("colorChanged",handleColorChange);
					_popover.addEventListener("colorCommit",handleColorCommit);
					_popover.addEventListener("cancel",handleCancel);
					_popover.addEventListener("openChanged",handleOpenChanged);
				}
			}
			return _popover;
		}
		protected function handleColorChange(ev:ValueEvent):void{
			button.color = ev.value;
			dispatchEvent(ev);
		}
		protected function handleColorCommit(ev:ValueEvent):void{
			button.color = ev.value;
			dispatchEvent(ev);
			closePopover();
		}
		protected function handleCancel(ev:ValueEvent):void{
			appliedColor = initialColor;
			dispatchEvent(ev);
			closePopover();
		}
		protected function handleOpenChanged(ev:Event):void{
			dispatchEvent(ev);
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
				closePopover();
			}
		}
		protected function setPopupProperties():void{
			popover.position = position;
			if(!appliedColor){
				appliedColor = new RGBColor([0,0,0,1]);
			}
			popover.appliedColor = appliedColor;
			popover.dataProvider = dataProvider;
			popover.applyText = applyText;
			popover.cancelText = cancelText;
			popover.showApplyButtons = showApplyButtons;
			popover.showColorControls = showColorControls;
			popover.showAlphaControls = showAlphaControls;
			popover.showSelectionSwatch = showSelectionSwatch;
			popover.areaSize = areaSize;
			popover.preferredColumns = preferredColumns;
			popover.preferredRows = preferredRows;
			popover.hexEditable = hexEditable;
		}
		public var initialColor:IRGBA;
		private var zIndexSet:Boolean = false;
		protected function openPopup():void{
			initialColor = appliedColor;
			popover.anchor = DisplayUtils.getScreenBoundingRect(button);
			if(!zIndexSet){
				var zIndex:Number = getExplicitZIndex(this);
				if(zIndex > 2){
					popover.setStyle("z-index",zIndex);
				}
				zIndexSet = true;
			}
			setPopupProperties();
			popover.open = true;
			button.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			popover.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
		}
		protected function closePopover():void{
			if(popover && popover.open){
				popover.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				button.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
				popover.open = false;
				COMPILE::JS
				{
					requestAnimationFrame(function():*{
						initialColor = null;
					});
				}
			}
		}
		protected function handleControlMouseDown(event:MouseEvent):void{
			event.stopImmediatePropagation();
		}
		protected function handleTopMostEventDispatcherMouseDown(event:MouseEvent):void{
			// If the user clicked outside the popover, we're considering that a cancel.
			cancelPopover();
		}
		public function cancelPopover():void{
			if(popover.open){
				dispatchEvent(new Event("cancel"));
				closePopover();
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