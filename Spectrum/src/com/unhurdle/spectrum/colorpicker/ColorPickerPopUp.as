package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.core.IColorSpectrumModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.utils.hsvToHex;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.html.supportClasses.ColorSpectrum;
	import org.apache.royale.html.beads.ISliderView;
	import com.unhurdle.spectrum.Popover;
	import org.apache.royale.core.IRangeModel;
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

	public class ColorPickerPopUp extends Popover implements IColorPopover
	{
		public function ColorPickerPopUp(){
			super();
			dialog=true;
			floating = true;
			mainContainer = new FlexContainer();
			mainContainer.vertical = true;
			addElement(mainContainer);
			// fixedSizeContainer = new Group();
			// colorArea = new ColorArea();
			// hueSelector = new ColorSlider();
			// hueSelector.vertical = true;
			// hueSelector.addEventListener("colorChanged", hueChangeHandler);
			// alphaSelector = new AlphaColorSlider();
			// alphaSelector.vertical = true;
			// alphaSelector.addEventListener("colorChanged", alphaSelectorChangeHandler);
			// _colorTextField = new ColorTextField();
			// _alphaTextField = new AlphaTextField();
			// _colorTextField.addEventListener("colorChange", colorTextFieldChangeHandler);
			// _alphaTextField.addEventListener("alphaChange", alphaTextFieldChangeHandler);
			// preventPropogation(_colorTextField);
			// preventPropogation(_alphaTextField);

			// COMPILE::JS 
			// {
			// 	hueSelector.element.style.position = "absolute";
			// 	_colorTextField.element.style.position = "absolute";
			// 	_alphaTextField.element.style.position = "absolute";
			// 	colorSpectrum.element.style.position = "absolute";
			// 	alphaSelector.element.style.position = "absolute";
			// 	fixedSizeContainer.element.style.position = "absolute";
			// }

			// fixedSizeContainer.addElement(colorSpectrum);
			// fixedSizeContainer.addElement(hueSelector);
			// fixedSizeContainer.addElement(alphaSelector);
			// fixedSizeContainer.addElement(_colorTextField);
			// fixedSizeContainer.addElement(_alphaTextField);
			// addElement(fixedSizeContainer);
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


		// protected function layout():void{
		// 	var squareDim:Number = 225;
		// 	var sliderWidth:Number = 30;
		// 	colorSpectrum.height =  squareDim;
		// 	colorSpectrum.width =  squareDim;
		// 	colorSpectrum.y = padding;
		// 	colorSpectrum.x = padding;
		// 	hueSelector.width = sliderWidth;
		// 	hueSelector.height = squareDim;
		// 	hueSelector.x = colorSpectrum.x + colorSpectrum.width + padding;
		// 	hueSelector.y = padding;
		// 	alphaSelector.width = sliderWidth;
		// 	alphaSelector.height = squareDim;
		// 	alphaSelector.x = hueSelector.x + sliderWidth + padding;
		// 	alphaSelector.y = padding;
		// 	_colorTextField.x = padding;
		// 	_colorTextField.y = colorSpectrum.y + colorSpectrum.height + padding;
		// 	_colorTextField.width = 132;
		// 	_alphaTextField.x = _colorTextField.width + _colorTextField.x + padding;
		// 	_alphaTextField.y = _colorTextField.y;
		// 	_alphaTextField.width = 66;
		// 	fixedSizeContainer.width = alphaSelector.x + alphaSelector.width + padding;
		// 	fixedSizeContainer.height = _colorTextField.y + 32 + padding;
		// 	width = fixedSizeContainer.width;
		// 	height = fixedSizeContainer.height;
		// }

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

		}
		protected var controlSection:FlexContainer;
		private function setupControls():void{
			if(showColorControls){
				if(!controlSection){
					controlSection = new FlexContainer();
					controlSection.vertical = false;
					mainContainer.addElement(controlSection);
				}
				if(!colorArea){
					colorArea = new ColorArea();
					// add event listener -- which?
					controlSection.addElement(colorArea);
				}
				// set the colorArea color

			}
			setupAlpha();
		}
		private function setupAlpha():void{
			if(showColorControls && showAlphaControls){

			}
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
					_colorTextField.addEventListener("colorChange", colorTextFieldChangeHandler);
					preventPropogation(_colorTextField);
				}
				if(showAlphaControls){
					if(!_alphaTextField){
						_alphaTextField = new AlphaTextField();
						_alphaTextField.addEventListener("alphaChange", alphaTextFieldChangeHandler);
						preventPropogation(_alphaTextField);
					}
				}
			}

		}
		private function setupSwatch():void{

		}
		private function setupButtons():void{
			if(showApplyButtons){

			}
		}
		// override public function set visible(value:Boolean):void
		// {
		// 	open = value;
		// 	super.visible = value;
		// 	if (value)
		// 	{
		// 		layout();
		// 	}
		// }
		
		private function hueChangeHandler(event:Event):void{
			(model as IColorModel).color = hsvToHex(hueSelector.value, 100, 100);
		}

		private function alphaSelectorChangeHandler(event:Event):void{
			(model as ArrayColorSelectionWithAlphaModel).alpha = (100 - alphaSelector.value) / 100;
		}

		// override public function set model(value:Object):void{
		// 	super.model = value;
		// 	(model as IEventDispatcher).addEventListener("change", colorModelChangeHandler)
		// 	var colorSpectrumModel:IColorSpectrumModel = loadBeadFromValuesManager(IColorSpectrumModel, "iColorSpectrumModel", colorSpectrum) as IColorSpectrumModel;
		// 	colorSpectrumModel.baseColor = (value as IColorModel).color;
		// 	var textFieldModel:IColorModel = loadBeadFromValuesManager(IColorModel, "iColorModel", _colorTextField) as IColorModel;
		// 	textFieldModel.color = (value as IColorModel).color;
		// 	var alphaTextFieldModel:IRangeModel = loadBeadFromValuesManager(IRangeModel, "iRangeModel", _alphaTextField) as IRangeModel;
		// 	alphaSelector.value = int((1- (value as ArrayColorSelectionWithAlphaModel).alpha) * 100);
		// 	alphaTextFieldModel.maximum = alphaSelector.maximum;
		// 	alphaTextFieldModel.minimum = alphaSelector.minimum;
		// 	alphaTextFieldModel.value = alphaSelector.value;
		// 	(colorSpectrum as IEventDispatcher).addEventListener("change", colorSpectrumChangeHandler);
		// 	(colorSpectrum as IEventDispatcher).addEventListener("thumbDown", colorSpectrumThumbDownHandler);
		// 	(colorSpectrum as IEventDispatcher).addEventListener("thumbUp", colorSpectrumThumbUpHandler);
		// }
		
		private var draggingThumb:Boolean;
		private var fromSpectrum:Boolean;
        
		protected function colorSpectrumChangeHandler(event:Event):void{
			fromSpectrum = true;
			(model as IColorModel).color = colorSpectrum.hsvModifiedColor;
		}
        
		private function colorModelChangeHandler(event:Event):void{
			var colorValue:uint = (event.target as IColorModel).color;
			(_colorTextField.model as IColorModel).color = colorValue;
			(_alphaTextField.model as IRangeModel).value = int((1 - (event.target as ArrayColorSelectionWithAlphaModel).alpha) * 100);
			if (fromSpectrum){
				fromSpectrum = false;
			} else {
				colorSpectrum.baseColor = colorValue;
			}
			alphaSelector.value = int((1- (event.target as ArrayColorSelectionWithAlphaModel).alpha) * 100);
			(alphaSelector.model as IColorModel).color = colorValue;
			if (open){
				(host as IEventDispatcher).dispatchEvent(new Event(Event.CHANGE));
			}
		}

		protected function colorSpectrumThumbDownHandler(event:Event):void{
			draggingThumb = true;
		}
		
		protected function colorSpectrumThumbUpHandler(event:Event):void{
			draggingThumb = false;
		}
		
		public function set strand(value:IStrand):void{
			host = value;
		}

		override public function addedToParent():void{
			super.addedToParent();
			var hueSelectorView:ISliderView = hueSelector.getBeadByType(ISliderView) as ISliderView;
			hueSelectorView.track.alpha = 0;
		}

		private function colorTextFieldChangeHandler(event:Event):void{
            (model as IColorModel).color = (_colorTextField.model as IColorModel).color;
		}

		private function alphaTextFieldChangeHandler(event:Event):void{
            (model as ArrayColorSelectionWithAlphaModel).alpha = (100 - (_alphaTextField.model as IRangeModel).value) / 100;
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

		private var _areaSize:Number = 92;// technically the default should be 240 on mobile
		public function get areaSize():Number{
			return _areaSize;
		}
		public function set areaSize(value:Number):void{
			_areaSize = value;
		}
	}
}
