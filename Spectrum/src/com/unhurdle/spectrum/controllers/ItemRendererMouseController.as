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
					
			
			COMPILE::SWF {
	            renderer.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
	            renderer.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				renderer.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				renderer.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
				
			COMPILE::JS {
				var element:WrappedHTMLElement = (_strand as UIBase).element;
				
				goog.events.listen(element, goog.events.EventType.MOUSEOVER, this.handleMouseOver);
				goog.events.listen(element, goog.events.EventType.MOUSEOUT, this.handleMouseOut);
				goog.events.listen(element, goog.events.EventType.MOUSEDOWN, this.handleMouseDown);
				goog.events.listen(element, goog.events.EventType.CLICK, this.handleMouseUp);
			}
		}
		
	
		COMPILE::SWF
		protected function rollOverHandler(event:MouseEvent):void
		{
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target)
			{
				target.dispatchEvent(new Event("itemRollOver",true));
			}
		}
		
	
		COMPILE::JS
		protected function handleMouseOver(event:BrowserEvent):void
		{
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target) {
				target.dispatchEvent(new Event("itemRollOver",true));
			}
		}
		

		COMPILE::SWF
		protected function rollOutHandler(event:MouseEvent):void
		{
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target)
			{
				target.dispatchEvent(new Event("itemRollOut",true));
			}
		}
	
		COMPILE::JS
		protected function handleMouseOut(event:BrowserEvent):void
		{
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target)
			{
				target.dispatchEvent(new Event("itemRollOut",true));
			}
		}

		COMPILE::SWF
		protected function mouseDownHandler(event:MouseEvent):void
		{
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target)
			{
                target.down = true;
				target.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
		}
	
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
		

		COMPILE::SWF
		protected function mouseUpHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target)
			{				
				var newEvent:ItemClickedEvent = new ItemClickedEvent("itemClicked");
				newEvent.data = target.data;
				newEvent.multipleSelection = event.shiftKey;
				newEvent.index = target.index;
				
                target.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);                
				target.dispatchEvent(newEvent);
			}			
		}
		
	
		COMPILE::JS
		protected function handleMouseUp(event:BrowserEvent):void
		{
			event.stopImmediatePropagation();
			var target:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (target && target.selectable)
			{
				var newEvent:ItemClickedEvent = new ItemClickedEvent("itemClicked");
				newEvent.data = target.data;
				newEvent.multipleSelection = event.shiftKey;
				newEvent.index = target.index;

				target.dispatchEvent(newEvent);
			}
		}
	
	}
}


