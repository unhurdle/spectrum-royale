package com.unhurdle.spectrum.controllers
{
  
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.IStrand;
COMPILE::SWF {
	import org.apache.royale.events.Event;
	import org.apache.royale.events.MouseEvent;
}
COMPILE::JS {
	import org.apache.royale.core.UIBase;
	import org.apache.royale.core.WrappedHTMLElement;
	import org.apache.royale.events.BrowserEvent;
	import goog.events.Event;
	import goog.events.EventType;
  import goog.events;
}
	import org.apache.royale.events.ItemClickedEvent;
	import org.apache.royale.core.IRuntimeSelectableItemRenderer;
	import org.apache.royale.core.IItemRenderer;
	import org.apache.royale.utils.getSelectionRenderBead;
	import org.apache.royale.core.IIndexedItemRenderer;

	
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
				
			COMPILE::JS {
				var element:WrappedHTMLElement = (_strand as UIBase).element;
				
				goog.events.listen(element, goog.events.EventType.MOUSEOVER, this.handleMouseOver);
				goog.events.listen(element, goog.events.EventType.MOUSEOUT, this.handleMouseOut);
				goog.events.listen(element, goog.events.EventType.MOUSEDOWN, this.handleMouseDown);
				goog.events.listen(element, goog.events.EventType.CLICK, this.handleMouseUp);
			}
		}
		
	
		
	
		/**
		 * @royaleemitcoercion org.apache.royale.core.IItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseOver(event:BrowserEvent):void
		{
			var target:IItemRenderer = event.currentTarget as IItemRenderer;
			if (target) {
				target.dispatchEvent(new Event("itemRollOver",true));
			}
		}
		

		/**
		 * @royaleemitcoercion org.apache.royale.core.IItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseOut(event:BrowserEvent):void
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
		COMPILE::JS
		protected function handleMouseDown(event:BrowserEvent):void
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
		COMPILE::JS
		protected function handleMouseUp(event:BrowserEvent):void
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


