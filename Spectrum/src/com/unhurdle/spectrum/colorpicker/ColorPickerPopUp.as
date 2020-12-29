package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.core.IColorSpectrumModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.utils.hsvToHex;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.core.IBead;
	import org.apache.royale.html.supportClasses.IColorPickerPopUp;
	import org.apache.royale.html.supportClasses.ColorSpectrum;
	import org.apache.royale.html.beads.ISliderView;
	import com.unhurdle.spectrum.Popover;
	import org.apache.royale.core.IRangeModel;
	import com.unhurdle.spectrum.ISpectrumElement;
	import com.unhurdle.spectrum.Group;
	import com.unhurdle.spectrum.ColorSlider;
	import com.unhurdle.spectrum.AlphaColorSlider;

	public class ColorPickerPopUp extends Popover implements IColorPickerPopUp, IBead
	{
		protected var colorSpectrum:ColorSpectrum;
		protected var hueSelector:ColorSlider;
		protected var alphaSelector:AlphaColorSlider;
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

		public function ColorPickerPopUp(){
			super();
			dialog=true;
			fixedSizeContainer = new Group();
			colorSpectrum = new ColorSpectrum();
			hueSelector = new ColorSlider();
			hueSelector.vertical = true;
			hueSelector.addEventListener("colorChanged", hueChangeHandler);
			alphaSelector = new AlphaColorSlider();
			alphaSelector.vertical = true;
			alphaSelector.addEventListener("colorChanged", alphaSelectorChangeHandler);
			_colorTextField = new ColorTextField();
			_alphaTextField = new AlphaTextField();
			_colorTextField.addEventListener("colorChange", colorTextFieldChangeHandler);
			_alphaTextField.addEventListener("alphaChange", alphaTextFieldChangeHandler);
			preventPropogation(_colorTextField);
			preventPropogation(_alphaTextField);

			// COMPILE::JS 
			// {
			// 	hueSelector.element.style.position = "absolute";
			// 	_colorTextField.element.style.position = "absolute";
			// 	_alphaTextField.element.style.position = "absolute";
			// 	colorSpectrum.element.style.position = "absolute";
			// 	alphaSelector.element.style.position = "absolute";
			// 	fixedSizeContainer.element.style.position = "absolute";
			// }

			fixedSizeContainer.addElement(colorSpectrum);
			fixedSizeContainer.addElement(hueSelector);
			fixedSizeContainer.addElement(alphaSelector);
			fixedSizeContainer.addElement(_colorTextField);
			fixedSizeContainer.addElement(_alphaTextField);
			addElement(fixedSizeContainer);
		}

		protected function layout():void{
			var squareDim:Number = 225;
			var sliderWidth:Number = 30;
			colorSpectrum.height =  squareDim;
			colorSpectrum.width =  squareDim;
			colorSpectrum.y = padding;
			colorSpectrum.x = padding;
			hueSelector.width = sliderWidth;
			hueSelector.height = squareDim;
			hueSelector.x = colorSpectrum.x + colorSpectrum.width + padding;
			hueSelector.y = padding;
			alphaSelector.width = sliderWidth;
			alphaSelector.height = squareDim;
			alphaSelector.x = hueSelector.x + sliderWidth + padding;
			alphaSelector.y = padding;
			_colorTextField.x = padding;
			_colorTextField.y = colorSpectrum.y + colorSpectrum.height + padding;
			_colorTextField.width = 132;
			_alphaTextField.x = _colorTextField.width + _colorTextField.x + padding;
			_alphaTextField.y = _colorTextField.y;
			_alphaTextField.width = 66;
			fixedSizeContainer.width = alphaSelector.x + alphaSelector.width + padding;
			fixedSizeContainer.height = _colorTextField.y + 32 + padding;
			width = fixedSizeContainer.width;
			height = fixedSizeContainer.height;
		}
		private function preventPropogation(element:ISpectrumElement):void{
			element.addEventListener("change", function(e:Event):void{
				e.stopImmediatePropagation();
			});
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

		override public function set model(value:Object):void{
			super.model = value;
			(model as IEventDispatcher).addEventListener("change", colorModelChangeHandler)
			var colorSpectrumModel:IColorSpectrumModel = loadBeadFromValuesManager(IColorSpectrumModel, "iColorSpectrumModel", colorSpectrum) as IColorSpectrumModel;
			colorSpectrumModel.baseColor = (value as IColorModel).color;
			var textFieldModel:IColorModel = loadBeadFromValuesManager(IColorModel, "iColorModel", _colorTextField) as IColorModel;
			textFieldModel.color = (value as IColorModel).color;
			var alphaTextFieldModel:IRangeModel = loadBeadFromValuesManager(IRangeModel, "iRangeModel", _alphaTextField) as IRangeModel;
			alphaSelector.value = int((1- (value as ArrayColorSelectionWithAlphaModel).alpha) * 100);
			alphaTextFieldModel.maximum = alphaSelector.maximum;
			alphaTextFieldModel.minimum = alphaSelector.minimum;
			alphaTextFieldModel.value = alphaSelector.value;
			(colorSpectrum as IEventDispatcher).addEventListener("change", colorSpectrumChangeHandler);
			(colorSpectrum as IEventDispatcher).addEventListener("thumbDown", colorSpectrumThumbDownHandler);
			(colorSpectrum as IEventDispatcher).addEventListener("thumbUp", colorSpectrumThumbUpHandler);
		}
		
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

		private function colorTextFieldChangeHandler(event:Event):void
		{
            (model as IColorModel).color = (_colorTextField.model as IColorModel).color;
		}

		private function alphaTextFieldChangeHandler(event:Event):void
		{
            (model as ArrayColorSelectionWithAlphaModel).alpha = (100 - (_alphaTextField.model as IRangeModel).value) / 100;
		}
	}
}
