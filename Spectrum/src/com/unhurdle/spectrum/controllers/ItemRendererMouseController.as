package com.unhurdle.spectrum.controllers
{
  
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IIndexedItemRenderer;
	import org.apache.royale.core.IItemRenderer;
	import org.apache.royale.core.IRuntimeSelectableItemRenderer;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.ItemClickedEvent;
	import org.apache.royale.utils.getSelectionRenderBead;
	import com.unhurdle.spectrum.Application;
	import com.unhurdle.spectrum.ISpectrumElement;

	
	public class ItemRendererMouseController implements IBeadController
	{
	
		public function ItemRendererMouseController()
		{
		}
		
		private var _strand:IStrand;
		COMPILE::JS
		private var pointerId:Number = -1;
		

		public function set strand(value:IStrand):void
		{
			_strand = value;
			var host:IEventDispatcher = _strand as IEventDispatcher;
			host.addEventListener("click", handleMouseUp);
			COMPILE::SWF
			{
				host.addEventListener("mouseover", handleMouseOver);
				host.addEventListener("mouseout", handleMouseOut);
				host.addEventListener("mousedown", handleMouseDown);
			}
			COMPILE::JS
			{
				if(Application.current.usePointerEvents){
					var element:HTMLElement = (_strand as ISpectrumElement).element;
					element.addEventListener("pointerenter", handlePointerEnter);
					element.addEventListener("pointerleave", handlePointerLeave);
					element.addEventListener("pointerdown", handlePointerDown);
				} else {
					host.addEventListener("mouseover", handleMouseOver);
					host.addEventListener("mouseout", handleMouseOut);
					host.addEventListener("mousedown", handleMouseDown);
				}
			}
		}

		COMPILE::JS
		private function handlePointerEnter(event:PointerEvent):void
		{
			if(event.pointerType != "touch"){
				dispatchRendererEvent("itemRollOver");
			}
		}

		COMPILE::JS
		private function handlePointerLeave(event:PointerEvent):void
		{
			if(event.pointerType != "touch"){
				dispatchRendererEvent("itemRollOut");
			}
		}

		COMPILE::JS
		private function handlePointerDown(event:PointerEvent):void
		{
			if(pointerId >= 0 || event.isPrimary === false || event.button != 0){
				return;
			}
			pointerId = event.pointerId;
			setDown(true);
			var element:HTMLElement = (_strand as ISpectrumElement).element;
			element.addEventListener("pointerup", handlePointerEnd);
			element.addEventListener("pointercancel", handlePointerEnd);
			element.addEventListener("lostpointercapture", handlePointerEnd);
			element["setPointerCapture"](pointerId);
		}

		COMPILE::JS
		private function handlePointerEnd(event:PointerEvent):void
		{
			if(event.pointerId != pointerId){
				return;
			}
			var activePointerId:Number = pointerId;
			pointerId = -1;
			var element:HTMLElement = (_strand as ISpectrumElement).element;
			element.removeEventListener("pointerup", handlePointerEnd);
			element.removeEventListener("pointercancel", handlePointerEnd);
			element.removeEventListener("lostpointercapture", handlePointerEnd);
			setDown(false);
			if(element["hasPointerCapture"](activePointerId)){
				element["releasePointerCapture"](activePointerId);
			}
		}

		private function dispatchRendererEvent(type:String):void
		{
			var target:IItemRenderer = _strand as IItemRenderer;
			if(target){
				target.dispatchEvent(new Event(type,true));
			}
		}

		private function setDown(value:Boolean):void
		{
			var target:IItemRenderer = _strand as IItemRenderer;
			var selectionBead:ISelectableItemRenderer = getSelectionRenderBead(target);
			if(selectionBead){
				selectionBead.down = value;
				if(value){
					selectionBead.hovered = false;
				}
			}
		}
		
	
		
	
		/**
		 * @royaleemitcoercion org.apache.royale.core.IItemRenderer
		 */
		protected function handleMouseOver(event:Event):void
		{
			var target:IItemRenderer = event.currentTarget as IItemRenderer;
			if (target) {
				target.dispatchEvent(new Event("itemRollOver",true));
			}
		}
		

		/**
		 * @royaleemitcoercion org.apache.royale.core.IItemRenderer
		 */
		protected function handleMouseOut(event:Event):void
		{
			var target:IItemRenderer = event.currentTarget as IItemRenderer;
			if (target)
			{
				target.dispatchEvent(new Event("itemRollOut",true));
			}
		}

	
		/**
		 * @royaleemitcoercion org.apache.royale.core.IItemRenderer
		 */
		protected function handleMouseDown(event:Event):void
		{
			setDown(true);
		}
		

		/**
		 * @royaleemitcoercion org.apache.royale.core.IRuntimeSelectableItemRenderer
		 * @royaleignorecoercion org.apache.royale.core.IIndexedItemRenderer
		 */
		protected function handleMouseUp(event:Event):void
		{
			event.stopImmediatePropagation();
			var target:IRuntimeSelectableItemRenderer = event.currentTarget as IRuntimeSelectableItemRenderer;
			if (target && target.selectable)
			{
				var newEvent:ItemClickedEvent = new ItemClickedEvent("itemClicked");
				var indexRenderer:IIndexedItemRenderer = target as IIndexedItemRenderer;
				newEvent.data = indexRenderer.data;
				newEvent.index = indexRenderer.index;

				indexRenderer.dispatchEvent(newEvent);
			}
		}
	
	}
}


