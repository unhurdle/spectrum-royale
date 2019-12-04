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
		 * @royaleemitcoercion org.apache.royale.core.IRuntimeSelectableItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseOver(event:BrowserEvent):void
		{
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target) {
				target.dispatchEvent(new Event("itemRollOver",true));
			}
		}
		

		/**
		 * @royaleemitcoercion org.apache.royale.core.IRuntimeSelectableItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseOut(event:BrowserEvent):void
		{
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target)
			{
				target.dispatchEvent(new Event("itemRollOut",true));
			}
		}

	
		/**
		 * @royaleemitcoercion org.apache.royale.core.IRuntimeSelectableItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseDown(event:BrowserEvent):void
		{
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target)
			{
				target.down = true;
				target.hovered = false;
			}
		}
		

		/**
		 * @royaleemitcoercion org.apache.royale.core.IRuntimeSelectableItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseUp(event:BrowserEvent):void
		{
			event.stopImmediatePropagation();
			var target:IRuntimeSelectableItemRenderer = event.currentTarget as IRuntimeSelectableItemRenderer;
			if (target && target.selectable)
			{
				var newEvent:ItemClickedEvent = new ItemClickedEvent("itemClicked");
				newEvent.data = target.data;
				newEvent.index = target.index;

				target.dispatchEvent(newEvent);
			}
		}
	
	}
}


