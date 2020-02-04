package view.components
{
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.core.IColorSpectrumModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.UIBase;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.html.HueSelector;
	import org.apache.royale.utils.hsvToHex;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.core.IBead;
	import org.apache.royale.html.supportClasses.IColorPickerPopUp;
	import org.apache.royale.html.supportClasses.ColorSpectrum;
	import org.apache.royale.html.beads.ISliderView;

	public class MyColorPickerPopUp extends UIBase implements IColorPickerPopUp, IBead
	{
		protected var colorSpectrum:ColorSpectrum;
		protected var hueSelector:HueSelector;
		protected var host:IStrand;
		protected var textField:MyColorTextField;

		public function MyColorPickerPopUp()
		{
			super();
			colorSpectrum = new ColorSpectrum();
			colorSpectrum.height =  300;
			colorSpectrum.width =  300;
			hueSelector = new HueSelector();
			hueSelector.width = 40;
			hueSelector.height = 300;
			hueSelector.x = 310;
            hueSelector.y = 0;
			hueSelector.addEventListener("valueChange", hueChangeHandler);
			textField = new MyColorTextField();
			textField.x = 10;
			textField.y = 310;
			COMPILE::JS 
			{
				hueSelector.element.style.position = "absolute";
				textField.element.style.position = "absolute";
			}
			addElement(colorSpectrum);
			addElement(hueSelector);
			addElement(textField);
			// var viewBead:ISliderView = host.view as ISliderView;
		}
		
		private function hueChangeHandler(event:Event):void
		{
			colorSpectrum.baseColor = hsvToHex(hueSelector.value, 100, 100);
		}

		override public function set model(value:Object):void
		{
			super.model = value;
			var colorSpectrumModel:IColorSpectrumModel = loadBeadFromValuesManager(IColorSpectrumModel, "iColorSpectrumModel", colorSpectrum) as IColorSpectrumModel;
			colorSpectrumModel.baseColor = (value as IColorModel).color;
			var textFieldModel:IColorModel = loadBeadFromValuesManager(IColorModel, "iColorModel", textField) as IColorModel;
			textFieldModel.color = (value as IColorModel).color;
			(colorSpectrum as IEventDispatcher).addEventListener("change", colorSpectrumChangeHandler);
            (colorSpectrum as IEventDispatcher).addEventListener("thumbDown", colorSpectrumThumbDownHandler);
            (colorSpectrum as IEventDispatcher).addEventListener("thumbUp", colorSpectrumThumbUpHandler);
		}
		
        private var draggingThumb:Boolean;
        
		protected function colorSpectrumChangeHandler(event:Event):void
		{
			(model as IColorModel).color = colorSpectrum.hsvModifiedColor;
            if (!draggingThumb)
                dispatchEvent(new Event("change"));
		}
        
        protected function colorSpectrumThumbDownHandler(event:Event):void
        {
            draggingThumb = true;
        }
        
        protected function colorSpectrumThumbUpHandler(event:Event):void
        {
            draggingThumb = false;
            (model as IColorModel).color = colorSpectrum.hsvModifiedColor;
            dispatchEvent(new Event("change"));
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
		
	}
}