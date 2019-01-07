package com.unhurdle.spectrum
{
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.core.IRollOverModel;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.ItemAddedEvent;
	import org.apache.royale.events.ItemRemovedEvent;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.html.beads.IListView;
	
	import org.apache.royale.events.ItemClickedEvent;

  public class MenuMouseController implements IBeadController
  {
    public function MenuMouseController()
    {
      
    }
    /**
     *  The model.
     */
		protected var listModel:ISelectionModel;

    /**
     *  The view.
     *  
     */
    protected var listView:IListView;

      /**
       *  The parent of the item renderers.
       */
      protected var dataGroup:IItemRendererParent;

    private var _strand:IStrand;
		
    /**
     *  @copy org.apache.royale.core.IBead#strand
     */
    public function set strand(value:IStrand):void
		{
			_strand = value;
			listModel = value.getBeadByType(ISelectionModel) as ISelectionModel;
			listView = value.getBeadByType(IListView) as IListView;
			(_strand as IEventDispatcher).addEventListener("itemAdded", handleItemAdded);
			(_strand as IEventDispatcher).addEventListener("itemRemoved", handleItemRemoved);
		}
		
    /**
     * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
     */
		protected function handleItemAdded(event:ItemAddedEvent):void
		{
			(event.item as IEventDispatcher).addEventListener("itemMouseUp", selectedHandler);
			(event.item as IEventDispatcher).addEventListener("itemRollOver", rolloverHandler);
			(event.item as IEventDispatcher).addEventListener("itemRollOut", rolloutHandler);
		}
		
        /**
         * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
         */
		protected function handleItemRemoved(event:ItemRemovedEvent):void
		{
			(event.item as IEventDispatcher).removeEventListener("itemMouseUp", selectedHandler);
			(event.item as IEventDispatcher).removeEventListener("itemRollOver", rolloverHandler);
			(event.item as IEventDispatcher).removeEventListener("itemRollOut", rolloutHandler);
		}
		
		protected function selectedHandler(event:ItemClickedEvent):void
    {
      listModel.selectedIndex = event.index;
      listModel.selectedItem = event.data;
      listView.host.dispatchEvent(new Event("change"));
    }
		
		/**
		 * @royaleemitcoercion org.apache.royale.core.ISelectableItemRenderer
     * @royaleignorecoercion org.apache.royale.core.IRollOverModel
		 */
		protected function rolloverHandler(event:Event):void
		{
			var renderer:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (renderer) {
				IRollOverModel(listModel).rollOverIndex = renderer.index;
			}
		}
		
		/**
		  * @royaleemitcoercion org.apache.royale.core.ISelectableItemRenderer
      * @royaleignorecoercion org.apache.royale.core.IRollOverModel
		 */
		protected function rolloutHandler(event:Event):void
		{
			var renderer:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (renderer) {
				renderer.hovered = false;
				renderer.down = false;
				IRollOverModel(listModel).rollOverIndex = -1;
			}
		}
	
	}
}
