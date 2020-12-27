package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IRenderedObject;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.utils.PointUtils;
	import org.apache.royale.geom.Point;
	import org.apache.royale.core.IRangeModel;
	import org.apache.royale.core.IStrandWithModel;
	import org.apache.royale.events.ValueChangeEvent;
	import org.apache.royale.utils.sendStrandEvent;
	
	public class VSliderMouseController implements IBead, IBeadController
	{
		private var _strand:IStrand;
		public function VSliderMouseController()
		{
		}
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			(value as IEventDispatcher).addEventListener('mousedown', onMouseDown);
		}

		protected function onMouseDown(e:MouseEvent):void {
			onMouseMove(e);
			window.addEventListener('mouseup', onMouseUp);
			window.addEventListener('mousemove', onMouseMove);
		}
		
		protected function onMouseUp():void {
			window.removeEventListener('mouseup', onMouseUp);
			window.removeEventListener('mousemove', onMouseMove);
		}

		protected function onMouseMove(e:MouseEvent):void {
			COMPILE::JS
			{
				var elem:HTMLElement = (_strand as IRenderedObject).element as HTMLElement;
				var sliderOffsetHeight:Number = elem.offsetHeight;
				var localY:Number = PointUtils.globalToLocal(new Point(e.clientX,e.clientY),_strand).y;
				var y:Number = Math.max(Math.min(localY, sliderOffsetHeight), 0);
				var ratio:Number = y / sliderOffsetHeight;
				var rangeModel:IRangeModel = (_strand as IStrandWithModel).model as IRangeModel;
				var val:Number = (rangeModel.maximum - rangeModel.minimum) * ratio +  rangeModel.minimum;
				var stepVal:Number = rangeModel.stepSize;
				var rem:Number = val % stepVal;
				val = val - rem;
				if (rem > (stepVal/2)){
					val += stepVal;
				}
				var vce:ValueChangeEvent = ValueChangeEvent.createUpdateEvent(_strand, "value", rangeModel.value, val);
				rangeModel.value = val;
				sendStrandEvent(_strand, vce);

			}
		}
	}
}
