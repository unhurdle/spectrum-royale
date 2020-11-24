
package com.unhurdle.spectrum
{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IPopUpHost;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.geom.Point;
	import org.apache.royale.utils.PointUtils;
	import org.apache.royale.utils.UIUtils;
	import com.unhurdle.spectrum.Tooltip;

	public class TooltipBead implements IBead
	{
		public function TooltipBead()
		{
		}

		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const BOTTOM:String = "bottom";
		public static const TOP:String = "top";

		private var _toolTip:String;
		protected var tt:Tooltip;
		protected var host:IPopUpHost;
		private var _direction:String = TOP;

		public function get toolTip():String
		{
			return _toolTip;
		}
		public function set toolTip(value:String):void
		{
			_toolTip = value;
		}

    [Inspectable(category="General", enumeration="left,right,bottom,top", defaultValue="top")]
		public function set direction(value:String):void
		{
			_direction = value;
			if (tt)
			{
				tt.direction = value;
			}
		}

		public function get direction():String
		{
			return _direction;
		}

		protected var _strand:IStrand;

		public function set strand(value:IStrand):void
		{
			_strand = value;

			(_strand as IEventDispatcher).addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler, false);
		}

		protected function rollOverHandler(event:MouseEvent):void
		{
			if (!toolTip || tt)
				return;

			(_strand as IEventDispatcher).addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler, false);

			var comp:IUIBase = _strand as IUIBase
			host = UIUtils.findPopUpHost(comp);
			if (tt)
				host.popUpParent.removeElement(tt);

			tt = new Tooltip();
			tt.direction = _direction;
			tt.style = {"position": "absolute"};
			tt.text = toolTip;
			host.popUpParent.addElement(tt, false); // don't trigger a layout
			var ttWidth:Number = tt.width;
			var pt:Point = determinePosition(_strand as IUIBase, tt);
			tt.x = pt.x;
			tt.y = pt.y;
			tt.isOpen = true;
			if(ttWidth != tt.width){
				pt = determinePosition(_strand as IUIBase, tt);
				tt.x = pt.x;
				tt.y = pt.y;
			}
		}

		protected function determinePosition(comp:IUIBase, tooltip:Tooltip):Point
		{
			var pt:Point = new Point();
			if (_direction == LEFT) {
				pt.x = -tooltip.width;
				pt.y = (comp.height - tooltip.height) / 2;
			} else if (_direction == TOP) {
				pt.x = (comp.width - tooltip.width) / 2;
				pt.y = -tooltip.height;
			} else if (_direction == RIGHT) {
				pt.x = comp.width;
				pt.y = (comp.height - tooltip.height) / 2;
			} else
			{
				pt.x = (comp.width - tooltip.width) / 2;
				pt.y = tooltip.height;
			}

			pt = PointUtils.localToGlobal(pt, comp);
			return pt;
		}

		protected function rollOutHandler(event:MouseEvent):void
		{
			(_strand as IEventDispatcher).removeEventListener(MouseEvent.MOUSE_OUT, rollOutHandler, false);

			var comp:IUIBase = _strand as IUIBase;
			if (tt) {
				host.popUpParent.removeElement(tt);
				tt = null;
			}
		}
	}
}

