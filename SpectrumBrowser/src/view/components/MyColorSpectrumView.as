package view.components
{
    import org.apache.royale.core.BeadViewBase;
    import org.apache.royale.core.IColorSpectrumModel;
    import org.apache.royale.core.IParent;
    import org.apache.royale.core.IRenderedObject;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.IStrandWithModel;
    import org.apache.royale.core.IUIBase;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.utils.CSSUtils;
    import org.apache.royale.utils.HSV;
    import org.apache.royale.utils.rgbToHsv;
    import org.apache.royale.html.beads.ISliderView;
    import org.apache.royale.html.elements.Div;
    import org.apache.royale.core.IStyleableObject;
	public class MyColorSpectrumView extends BeadViewBase implements ISliderView
	{
		private var _thumb:Div;
		public function MyColorSpectrumView()
		{
			super();
		}
		
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			(value as IStyleableObject).className = "ColorSpectrum";
			_thumb = new Div();
			_thumb.className = "spectrum-Slider-handle";
			_thumb.style = {"position" : "absolute", "padding" : 0, "backgroundColor" : "transparent"};
			(value as IParent).addElement(_thumb);
			(colorModel as IEventDispatcher).addEventListener("baseColorChange", changeHandler);
			(colorModel as IEventDispatcher).addEventListener("hsvModifiedColorChange", changeHandler);
			updateSpectrum();
		}
		
		private function changeHandler(e:Event):void
		{
			updateSpectrum();
		}
		
		public function get track():IUIBase
		{
			return _strand as IUIBase;
		}

		public function get thumb():IUIBase
		{
			return _thumb;
		}
		
		protected function updateSpectrum():void
		{
			var color:String = CSSUtils.attributeFromColor(colorModel.baseColor);
			COMPILE::JS
			{
				(host as IRenderedObject).element.style.background = "linear-gradient(to top, #000000, transparent), linear-gradient(to left, " + color + ", #ffffff)";
			}
			var hsvModifiedColor:uint = colorModel.hsvModifiedColor || colorModel.baseColor;
			var r:uint = (hsvModifiedColor >> 16 ) & 255;
			var g:uint = (hsvModifiedColor >> 8 ) & 255;
			var b:uint = hsvModifiedColor & 255;
			var hsv:HSV = rgbToHsv(r,g,b);
			_thumb.x = (hsv.s / 100) * host.width;
			_thumb.y = host.height - hsv.v * host.height / 100;
		}
		
		private function get colorModel():IColorSpectrumModel
		{
			return (host as IStrandWithModel).model as IColorSpectrumModel;
		}
	}
}
