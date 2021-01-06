package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.Popover;
	import com.unhurdle.spectrum.ISpectrumElement;
	import com.unhurdle.spectrum.Group;
	import com.unhurdle.spectrum.ColorSlider;
	import com.unhurdle.spectrum.AlphaColorSlider;
	import com.unhurdle.spectrum.interfaces.IColorPopover;
	import com.unhurdle.spectrum.interfaces.IRGBA;
	import com.unhurdle.spectrum.ColorArea;
	import com.unhurdle.spectrum.FlexContainer;
	import com.unhurdle.spectrum.List;
	import com.unhurdle.spectrum.beads.TileLayout;
	import org.apache.royale.collections.IArrayList;
	import org.apache.royale.collections.ICollectionView;
	import org.apache.royale.events.ValueEvent;
	import org.apache.royale.utils.rgbToHsv;
	import com.unhurdle.spectrum.ColorSwatch;

	[Event(name="colorChanged", type="com.unhurdle.spectrum.events.ColorChangeEvent")]
	[Event(name="colorCommit", type="org.apache.royale.events.ValueEvent")]
	[Event(name="cancel", type="org.apache.royale.events.Event")]
	public class ColorPickerPopUp extends Popover implements IColorPopover
	{
		public function ColorPickerPopUp(){
			super();
			dialog=true;
			floating = true;
			mainContainer = new FlexContainer();
			mainContainer.vertical = true;
			// mainContainer.alignItems  = "stretch";
			addElement(mainContainer);
		}
		protected var mainContainer:FlexContainer;
		protected var colorArea:ColorArea;
		protected var hueSelector:ColorSlider;
		protected var alphaSelector:AlphaColorSlider;
		protected var swatchList:List;
		protected var host:IStrand;
		
		private var _colorTextField:ColorTextField;
		public function get colorTextField():ColorTextField{
			return _colorTextField;
		}

		private var _alphaTextField:AlphaTextField;
		public function get alphaTextField():AlphaTextField{
			return _alphaTextField;
		}
		protected var fixedSizeContainer:Group;
		protected var padding:Number = 18;

		private function preventPropogation(element:ISpectrumElement):void{
			element.addEventListener("change", function(e:Event):void{
				e.stopImmediatePropagation();
			});
		}
		override public function set open(value:Boolean):void{
			// Setup the contents
			setupList();
			setupControls();
			setupFields();
			setupSwatch()
			setupButtons();
			super.open = value;
		}
		private function setupList():void{
			if(dataProvider){
				if(!swatchList){
					swatchList = new List();
					var layout:TileLayout = new TileLayout();
					layout.columnGap = 4;
					layout.rowGap = 4;
					swatchList.dataProvider = dataProvider;
					swatchList.addBead(layout);
					swatchList.addEventListener("change",onSwatchChange);
					mainContainer.addElement(swatchList);
				}
				// set the selected swatch if any.
				var color:IRGBA = appliedColor;
				var colorIndex:int = -1;
				if(dataProvider is Array){
					colorIndex = (dataProvider as Array).indexOf(color);
				} else if(dataProvider is IArrayList || dataProvider is ICollectionView){
					colorIndex = (dataProvider as IArrayList).getItemIndex(color);
				} else if(dataProvider["length"]){
					var length:int = dataProvider["length"];
					for(var i:int=0;i<length;i++){
						if(dataProvider[i] == color){
							colorIndex = i;
							break;
						}
					}
				}
				swatchList.selectedIndex = colorIndex;
			}
		}
		private function onSwatchChange(ev:Event):void{
			trace('onSwatchChange');
			trace(ev);
		}
		protected var controlSection:FlexContainer;
		private function setupControls():void{
			if(showColorControls){
				if(!controlSection){
					controlSection = new FlexContainer();
					controlSection.vertical = false;
					controlSection.alignItems = "stretch";
					mainContainer.addElement(controlSection);
				}
				// first color area
				if(!colorArea){
					colorArea = new ColorArea();
					colorArea.size = areaSize;
					colorArea.addEventListener("colorChanged",handleColorAreaChange);
					// add event listener -- which?
					controlSection.addElement(colorArea);
				}
				// set the colorArea color
				colorArea.appliedColor = appliedColor;
				// then hue slider
				if(!hueSelector){
					hueSelector = new ColorSlider();
					hueSelector.vertical = true;
					hueSelector.addEventListener("colorChanged",handleHueChange);
					controlSection.addElement(hueSelector);
				}
				hueSelector.appliedColor = appliedColor;

			}
			setupAlpha();
		}
		private function handleColorAreaChange(ev:ValueEvent):void{
			trace('handleColorAreaChange');
			trace(ev);
		}
		private function handleHueChange(ev:ValueEvent):void{
			var c:IRGBA = hueSelector.appliedColor;
			colorArea.hue = rgbToHsv(c.r,c.g,c.b).h;
			dispatchEvent(new ValueEvent("colorChanged",colorArea.appliedColor));
		}
		private function setupAlpha():void{
			if(showColorControls && showAlphaControls){
				if(!alphaSelector){
					alphaSelector = new AlphaColorSlider();
					alphaSelector.vertical = true;
					alphaSelector.addEventListener("colorChanged",handleAlphaChange)
					controlSection.addElement(alphaSelector);
				}
				alphaSelector.appliedColor = appliedColor;
			}
		}
		private function handleAlphaChange(ev:ValueEvent):void{
			trace("handleAlphaChange");
			trace(ev);
		}
		protected var fieldContainer:FlexContainer;
		private function setupFields():void{
			if(showColorControls){
				if(!fieldContainer){
					fieldContainer = new FlexContainer();
					fieldContainer.vertical = false;
					mainContainer.addElement(fieldContainer);
				}
				if(!_colorTextField){
					_colorTextField = new ColorTextField();
					if(hexEditable){
						_colorTextField.addEventListener("inputFinished", colorTextFieldChangeHandler);
					} else {
						_colorTextField.readonly = true;
					}
					preventPropogation(_colorTextField);
					fieldContainer.addElement(_colorTextField);
				}
				_colorTextField.text = appliedColor.hexString;
				if(showAlphaControls){
					if(!_alphaTextField){
						_alphaTextField = new AlphaTextField();
						_alphaTextField.addEventListener("inputFinished", alphaTextFieldChangeHandler);
						preventPropogation(_alphaTextField);
					}
				}
			}

		}
		private var originalColor:IRGBA;
		private var startSwatch:ColorSwatch;
		private var currentSwatch:ColorSwatch;
		private var swatchContainer:FlexContainer;
		private function setupSwatch():void{
			if(!showSelectionSwatch){
				return;
			}
			if(!swatchContainer){
				swatchContainer = new FlexContainer();
				swatchContainer.vertical = false;
			}

		}
		private function setupButtons():void{
			if(showApplyButtons){

			}
		}

		private function colorTextFieldChangeHandler(event:Event):void{
			trace('colorTextFieldChangeHandler');
			trace(event);
			//TODO figure out if the color changed
      // (model as IColorModel).color = (_colorTextField.model as IColorModel).color;
		}

		private function alphaTextFieldChangeHandler(event:Event):void{
			trace('alphaTextFieldChangeHandler');
			trace(event);
			//TODO figure out if the alpha changed
			//(model as ArrayColorSelectionWithAlphaModel).alpha = (100 - (_alphaTextField.model as IRangeModel).value) / 100;
		}
		private var _appliedColor:IRGBA;
		public function get appliedColor():IRGBA{
			return _appliedColor;
		}
		public function set appliedColor(value:IRGBA):void{
			_appliedColor = value;
		}

		private var _showSelectionSwatch:Boolean;
		public function get showSelectionSwatch():Boolean{
			return _showSelectionSwatch;
		}
		public function set showSelectionSwatch(value:Boolean):void{
			_showSelectionSwatch = value;
		}

		private var _showAlphaControls:Boolean;
		public function get showAlphaControls():Boolean{
			return _showAlphaControls;
		}
		public function set showAlphaControls(value:Boolean):void{
			_showAlphaControls = value;
		}

		private var _cancelText:String = "Cancel";
		public function get cancelText():String{
			return _cancelText
		}
		public function set cancelText(value:String):void{
			_cancelText = value;
		}

		private var _showColorControls:Boolean;
		public function get showColorControls():Boolean{
			return _showColorControls;
		}
		public function set showColorControls(value:Boolean):void{
			_showColorControls = value;
		}
		private var _hexEditable:Boolean;
		/**
		 * Whether the hex value is editable
		 */
		public function get hexEditable():Boolean{
			return _hexEditable;
		}
		public function set hexEditable(value:Boolean):void{
			_hexEditable = value;
		}
		private var _dataProvider:Object;
		public function get dataProvider():Object{
			return _dataProvider;
		}
		public function set dataProvider(value:Object):void{
			_dataProvider = value;
			if(swatchList){
				swatchList.dataProvider = value;
			}
		}

		private var _applyText:String = "Apply";
		public function get applyText():String{
			return _applyText;
		}
		public function set applyText(value:String):void{
			_applyText = value;
		}

		private var _showApplyButtons:Boolean;
		public function get showApplyButtons():Boolean{
			return _showApplyButtons;
		}

		public function set showApplyButtons(value:Boolean):void{
			_showApplyButtons = value;
		}

		private var _areaSize:Number = 192;// technically the default should be 240 on mobile
		public function get areaSize():Number{
			return _areaSize;
		}
		public function set areaSize(value:Number):void{
			_areaSize = value;
		}
	}
}
