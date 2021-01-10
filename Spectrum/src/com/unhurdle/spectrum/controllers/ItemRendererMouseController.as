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

	
	public class ItemRendererMouseController implements IBeadController
	{
	
		public function ItemRendererMouseController()
		{
		}
		
    private var renderer:ISelectableItemRenderer;
		private var _strand:IStrand;
		

		public function set strand(value:IStrand):void
		{
			_strand = value;
      renderer = value as ISelectableItemRenderer;
					
			
			// COMPILE::SWF {
	    //         renderer.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
	    //         renderer.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			// 	renderer.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			// 	renderer.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			// }
				
			var host:IEventDispatcher = _strand as IEventDispatcher;
			host.addEventListener("mouseover", handleMouseOver);
			host.addEventListener("mouseout", handleMouseOut);
			host.addEventListener("mousedown", handleMouseDown);
			host.addEventListener("click", handleMouseUp);
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
			var target:IItemRenderer = event.currentTarget as IItemRenderer;
			if (target)
			{
				var selectionBead:ISelectableItemRenderer = getSelectionRenderBead(target);
				if(selectionBead){
					selectionBead.down = true;
					selectionBead.hovered = false;
				}
			}
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


