package com.unhurdle.spectrum
{
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IItemRendererOwnerView;
	import org.apache.royale.core.IRollOverModel;
	import org.apache.royale.core.IIndexedItemRenderer;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.ItemAddedEvent;
	import org.apache.royale.events.ItemRemovedEvent;
	import org.apache.royale.html.beads.IListView;

	import org.apache.royale.events.ItemClickedEvent;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import com.unhurdle.spectrum.interfaces.IKeyboardHandler;
	import org.apache.royale.utils.sendStrandEvent;

	public class MenuController extends ListController
	{
		public function MenuController()
		{
			
		}
		
		/**
		 * Use itemMouseUp instead of itemMouseClick for menus
		 */
		override protected function handleItemAdded(event:ItemAddedEvent):void
		{
			(event.item as IEventDispatcher).addEventListener("itemMouseUp", selectedHandler);
			(event.item as IEventDispatcher).addEventListener("itemRollOver", rolloverHandler);
			(event.item as IEventDispatcher).addEventListener("itemRollOut", rolloutHandler);
		}
		
		override protected function handleItemRemoved(event:ItemRemovedEvent):void
		{
			(event.item as IEventDispatcher).removeEventListener("itemMouseUp", selectedHandler);
			(event.item as IEventDispatcher).removeEventListener("itemRollOver", rolloverHandler);
			(event.item as IEventDispatcher).removeEventListener("itemRollOut", rolloutHandler);
		}
				
	}
}