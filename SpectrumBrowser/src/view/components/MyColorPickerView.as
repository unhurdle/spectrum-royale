package view.components
{
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IStyleableObject;
	import org.apache.royale.html.elements.Div;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.html.beads.IComboBoxView;
	import org.apache.royale.core.BeadViewBase;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.core.IPopUp;
	import org.apache.royale.html.supportClasses.IColorPickerPopUp;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.core.IStrandWithModel;
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.geom.Point;
	import org.apache.royale.utils.PointUtils;
	import org.apache.royale.core.IRenderedObject;
	import org.apache.royale.core.IPopUpHost;
	import org.apache.royale.utils.UIUtils;
	import org.apache.royale.utils.CSSUtils;
	import org.apache.royale.core.UIBase;

	public class MyColorPickerView extends BeadViewBase implements IComboBoxView
	{
		public function MyColorPickerView()
		{
			super();
		}
		
		protected var selectedColorDisplay:Div;
		public function get textInputField():Object
		{
			return selectedColorDisplay;
		}

		private var list:IUIBase;

		public function get popUp():Object
		{
			return list;
		}

		public function get popupButton():Object
		{
			return selectedColorDisplay;
		}

		override public function set strand(value:IStrand):void
		{
			_strand = value;
			var host:UIBase = value as UIBase;
			
			selectedColorDisplay = new Div();
			selectedColorDisplay.percentWidth = 100;
			selectedColorDisplay.percentHeight = 100;
			(host as IStyleableObject).className = "CheckeredBackground";
			(selectedColorDisplay as IStyleableObject).className = "ColorPickerDisplayedColor";			
			
			if (isNaN(host.width)) selectedColorDisplay.width = 44;
			
			COMPILE::JS 
			{
				// inner components are absolutely positioned so we want to make sure the host is the offset parent
				if (!host.element.style.position)
				{
					host.element.style.position = "relative";
				}
			}
			host.addElement(selectedColorDisplay);
			
            loadBeadFromValuesManager(IPopUp, "iPopUp", _strand);
			list = _strand.getBeadByType(IColorPickerPopUp) as IUIBase;
			list.visible = false;
			
			var model:IEventDispatcher = (_strand as IStrandWithModel).model as IEventDispatcher;
			(list as IColorPickerPopUp).model = model;
			model.addEventListener("change", handleColorChange);
			
			IEventDispatcher(_strand).addEventListener("sizeChanged", handleSizeChange);
			
			// set initial value and positions using default sizes
			colorChangeAction();
			sizeChangeAction();
		}
		
		public function get popUpVisible():Boolean
		{
			if (list) return list.visible;
			else return false;
		}

		public function set popUpVisible(value:Boolean):void
		{
			if (value && !list.visible) {
				var model:IColorModel = _strand.getBeadByType(IColorModel) as IColorModel;
				(list as IColorPickerPopUp).model = model;
				list.visible = true;
				var position:String = (_strand as ColorArea).position;
				var myX:Number;
				var myY:Number;
				var gap:Number = 0;
				var strandWidth:Number = (_strand as IUIBase).width;
				var strandHeight:Number = (_strand as IUIBase).height;
				switch (position) {
					case "top":
						myX = -list.width / 2 + strandWidth / 2;
						myY = -list.height - gap;
						break;
					case "right":
						myX = list.width + gap;
						myY = -list.height / 2 + strandHeight / 2;
						break;
					case "left":
						myX = -list.width - gap;
						myY = -list.height / 2 + strandHeight / 2;
						break;
					default:
						myX = -list.width / 2 + strandWidth / 2;
						myY = selectedColorDisplay.height + gap;
				}

				
				var origin:Point = new Point(myX, myY);
				var relocated:Point = PointUtils.localToGlobal(origin,_strand);
				list.x = relocated.x
				list.y = relocated.y;
				COMPILE::JS {
					(list as IRenderedObject).element.style.position = "absolute";
				}
					
				var popupHost:IPopUpHost = UIUtils.findPopUpHost(_strand as IUIBase);
				popupHost.popUpParent.addElement(list);
				(list as MyColorPickerPopUp).position = position;
			}
			else if (list.visible) {
				UIUtils.removePopUp(list);
				list.visible = false;
			}
		}
		
		protected function handleSizeChange(event:Event):void
		{
			sizeChangeAction();
		}
		
		protected function handleColorChange(event:Event):void
		{
			colorChangeAction();
		}
		
		protected function colorChangeAction():void
		{
			var model:ArrayColorSelectionWithAlphaModel = _strand.getBeadByType(ArrayColorSelectionWithAlphaModel) as ArrayColorSelectionWithAlphaModel;
			COMPILE::JS 
			{
				var r:uint = (model.color >> 16 ) & 255;
				var g:uint = (model.color >> 8 ) & 255;
				var b:uint = model.color & 255;
				var colorStr:String = "rgba(" + r + ", " + g + ", " + b + ", " + model.alpha + ")";
				selectedColorDisplay.element.style.backgroundColor = colorStr;
			}
		}
		
		protected function sizeChangeAction():void
		{
			var host:UIBase = UIBase(_strand);
			
			selectedColorDisplay.x = 0;
			selectedColorDisplay.y = 0;
			selectedColorDisplay.height = 28;
			if (host.isWidthSizedToContent()) {
				selectedColorDisplay.width = 44;
			} else {
				selectedColorDisplay.width = host.width - 20;
			}

			COMPILE::JS {
				selectedColorDisplay.element.style.position = "absolute";
			}
				
			if (host.isHeightSizedToContent()) {
				host.height = selectedColorDisplay.height;
			}
			if (host.isWidthSizedToContent()) {
				host.width = selectedColorDisplay.width;
			}
        }
    }
}
