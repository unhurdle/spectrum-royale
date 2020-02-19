package view.components
{
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.core.IColorSpectrumModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.html.HueSelector;
	import org.apache.royale.utils.hsvToHex;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.core.IBead;
	import org.apache.royale.html.supportClasses.IColorPickerPopUp;
	import org.apache.royale.html.supportClasses.ColorSpectrum;
	import org.apache.royale.html.beads.ISliderView;
	import com.unhurdle.spectrum.Popover;
	import org.apache.royale.core.IRangeModel;
	import org.apache.royale.html.elements.Div;

	public class MyColorPickerPopUp extends Popover implements IColorPickerPopUp, IBead
	{
		protected var colorSpectrum:ColorSpectrum;
		protected var hueSelector:HueSelector;
		protected var alphaSelector:MyAlphaSelector;
		protected var host:IStrand;
		protected var colorTextField:MyColorTextField;
		protected var alphaTextField:MyAlphaTextField;
		protected var fixedSizeContainer:Div;
		protected var padding:Number = 18;

		public function MyColorPickerPopUp()
		{
			super();
			dialog=true;
			fixedSizeContainer = new Div();
			var squareDim:Number = 225;
			var sliderWidth:Number = 30;
			colorSpectrum = new ColorSpectrum();
			colorSpectrum.height =  squareDim;
			colorSpectrum.width =  squareDim;
			colorSpectrum.y = padding;
			colorSpectrum.x = padding;
			hueSelector = new HueSelector();
			hueSelector.width = sliderWidth;
			hueSelector.height = squareDim;
			hueSelector.x = colorSpectrum.x + colorSpectrum.width + padding;
            hueSelector.y = padding;
			hueSelector.addEventListener("valueChange", hueChangeHandler);
			alphaSelector = new MyAlphaSelector();
			alphaSelector.width = sliderWidth;
			alphaSelector.height = squareDim;
			alphaSelector.x = hueSelector.x + sliderWidth + padding;
            alphaSelector.y = padding;
			alphaSelector.addEventListener("valueChange", alphaSelectorChangeHandler);
			colorTextField = new MyColorTextField();
			colorTextField.x = padding;
			colorTextField.y = colorSpectrum.y + colorSpectrum.height + padding;
			colorTextField.width = 132;
			alphaTextField = new MyAlphaTextField();
			alphaTextField.x = colorTextField.width + colorTextField.x + padding;
			alphaTextField.y = colorTextField.y;
			alphaTextField.width = 66;
			fixedSizeContainer.width = alphaSelector.x + alphaSelector.width + padding;
			fixedSizeContainer.height = colorTextField.y + 32 + padding;
			colorTextField.addEventListener("colorChange", colorTextFieldChangeHandler);
			alphaTextField.addEventListener("alphaChange", alphaTextFieldChangeHandler);
			colorTextField.addEventListener("change", stopChangePropagation);
			alphaTextField.addEventListener("change", stopChangePropagation);

			COMPILE::JS 
			{
				hueSelector.element.style.position = "absolute";
				colorTextField.element.style.position = "absolute";
				alphaTextField.element.style.position = "absolute";
				colorSpectrum.element.style.position = "absolute";
				alphaSelector.element.style.position = "absolute";
				fixedSizeContainer.element.style.position = "absolute";
			}
			fixedSizeContainer.addElement(colorSpectrum);
			fixedSizeContainer.addElement(hueSelector);
			fixedSizeContainer.addElement(alphaSelector);
			fixedSizeContainer.addElement(colorTextField);
			fixedSizeContainer.addElement(alphaTextField);
			addElement(fixedSizeContainer);
			width = fixedSizeContainer.width;
			height = fixedSizeContainer.height;
		}

		private function stopChangePropagation(e:Event):void
		{
			e.stopImmediatePropagation();
		}

		override public function set visible(value:Boolean):void
		{
			open = value;
			super.visible = value;
		}
		
		private function hueChangeHandler(event:Event):void
		{
			(model as IColorModel).color = hsvToHex(hueSelector.value, 100, 100);
		}

		private function alphaSelectorChangeHandler(event:Event):void
		{
			(model as ArrayColorSelectionWithAlphaModel).alpha = (100 - alphaSelector.value) / 100;
		}

		override public function set model(value:Object):void
		{
			super.model = value;
			(model as IEventDispatcher).addEventListener("change", colorModelChangeHandler)
			var colorSpectrumModel:IColorSpectrumModel = loadBeadFromValuesManager(IColorSpectrumModel, "iColorSpectrumModel", colorSpectrum) as IColorSpectrumModel;
			colorSpectrumModel.baseColor = (value as IColorModel).color;
			var textFieldModel:IColorModel = loadBeadFromValuesManager(IColorModel, "iColorModel", colorTextField) as IColorModel;
			textFieldModel.color = (value as IColorModel).color;
			var alphaTextFieldModel:IRangeModel = loadBeadFromValuesManager(IRangeModel, "iRangeModel", alphaTextField) as IRangeModel;
			alphaSelector.value = (1- (value as ArrayColorSelectionWithAlphaModel).alpha) * 100;
			alphaTextFieldModel.maximum = alphaSelector.maximum;
			alphaTextFieldModel.minimum = alphaSelector.minimum;
			alphaTextFieldModel.value = alphaSelector.value;
			(colorSpectrum as IEventDispatcher).addEventListener("change", colorSpectrumChangeHandler);
            (colorSpectrum as IEventDispatcher).addEventListener("thumbDown", colorSpectrumThumbDownHandler);
            (colorSpectrum as IEventDispatcher).addEventListener("thumbUp", colorSpectrumThumbUpHandler);
		}
		
        private var draggingThumb:Boolean;
        private var fromSpectrum:Boolean;
        
		protected function colorSpectrumChangeHandler(event:Event):void
		{
			fromSpectrum = true;
			(model as IColorModel).color = colorSpectrum.hsvModifiedColor;
		}
        
		private function colorModelChangeHandler(event:Event):void
		{
			var colorValue:uint = (event.target as IColorModel).color;
			(colorTextField.model as IColorModel).color = colorValue;
			(alphaTextField.model as IRangeModel).value = int((1 - (event.target as ArrayColorSelectionWithAlphaModel).alpha) * 100);
			if (fromSpectrum)
			{
				fromSpectrum = false;
			} else
			{
				colorSpectrum.baseColor = colorValue;
			}
			alphaSelector.value = int((1- (event.target as ArrayColorSelectionWithAlphaModel).alpha) * 100);
			(alphaSelector.model as IColorModel).color = colorValue;
		}

        protected function colorSpectrumThumbDownHandler(event:Event):void
        {
            draggingThumb = true;
        }
        
        protected function colorSpectrumThumbUpHandler(event:Event):void
        {
            draggingThumb = false;
        }
		
		public function set strand(value:IStrand):void
		{
			host = value;
		}

        override public function addedToParent():void
        {
            super.addedToParent();
            var hueSelectorView:ISliderView = hueSelector.getBeadByType(ISliderView) as ISliderView;
            hueSelectorView.track.alpha = 0;
        }
		
		private function colorTextFieldChangeHandler(event:Event):void
		{
            (model as IColorModel).color = (colorTextField.model as IColorModel).color;
		}

		private function alphaTextFieldChangeHandler(event:Event):void
		{
            (model as ArrayColorSelectionWithAlphaModel).alpha = (100 - (alphaTextField.model as IRangeModel).value) / 100;
		}
	}
}