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

	public class MyColorPickerPopUp extends Popover implements IColorPickerPopUp, IBead
	{
		protected var colorSpectrum:ColorSpectrum;
		protected var hueSelector:HueSelector;
		protected var alphaSelector:MyAlphaSelector;
		protected var host:IStrand;
		protected var textField:MyColorTextField;

		public function MyColorPickerPopUp()
		{
			super();
			dialog=true;
			var padding:Number = 18;
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
			textField = new MyColorTextField();
			textField.x = padding;
			textField.y = colorSpectrum.y + colorSpectrum.height + padding;
			textField.width = 132;
			width = alphaSelector.x + alphaSelector.width + padding;
			height = textField.y + 32 + padding;
			textField.addEventListener("colorChange", textFieldChangeHandler);

			COMPILE::JS 
			{
				hueSelector.element.style.position = "absolute";
				textField.element.style.position = "absolute";
				colorSpectrum.element.style.position = "absolute";
				alphaSelector.element.style.position = "absolute";
			}
			addElement(colorSpectrum);
			addElement(hueSelector);
			addElement(alphaSelector);
			addElement(textField);
			// var viewBead:ISliderView = host.view as ISliderView;
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
			(model as ColorWithAlphaModel).alpha = (100 - alphaSelector.value) / 100;
		}

		override public function set model(value:Object):void
		{
			super.model = value;
			(model as IEventDispatcher).addEventListener("change", colorModelChangeHandler)
			var colorSpectrumModel:IColorSpectrumModel = loadBeadFromValuesManager(IColorSpectrumModel, "iColorSpectrumModel", colorSpectrum) as IColorSpectrumModel;
			colorSpectrumModel.baseColor = (value as IColorModel).color;
			var textFieldModel:IColorModel = loadBeadFromValuesManager(IColorModel, "iColorModel", textField) as IColorModel;
			textFieldModel.color = (value as IColorModel).color;
			alphaSelector.color = (value as IColorModel).color;
			(colorSpectrum as IEventDispatcher).addEventListener("change", colorSpectrumChangeHandler);
            (colorSpectrum as IEventDispatcher).addEventListener("thumbDown", colorSpectrumThumbDownHandler);
            (colorSpectrum as IEventDispatcher).addEventListener("thumbUp", colorSpectrumThumbUpHandler);
		}
		
        private var draggingThumb:Boolean;
        
		protected function colorSpectrumChangeHandler(event:Event):void
		{
			(model as IColorModel).color = colorSpectrum.hsvModifiedColor;
		}
        
		private function colorModelChangeHandler(event:Event):void
		{
			var colorValue:uint = (event.target as IColorModel).color;
			(textField.model as IColorModel).color = colorValue;
			colorSpectrum.baseColor = colorValue;
			alphaSelector.value = int((1- (event.target as ColorWithAlphaModel).alpha) * 100)
			alphaSelector.color = colorValue;
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
		

		private function textFieldChangeHandler(event:Event):void
		{
            (model as IColorModel).color = (textField.model as IColorModel).color;
		}
	}
}