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

  public class MenuController implements IBeadController
  {
    public function MenuController()
    {
      
    }
    /**
     *  The model.
     */
		protected var listModel:MenuModel;

    /**
     *  The view.
     *  
     */
    protected var listView:IListView;

      /**
       *  The parent of the item renderers.
       */
      protected var dataGroup:IItemRendererOwnerView;

    private var _strand:IStrand;
		
    /**
     *  @copy org.apache.royale.core.IBead#strand
     */
    public function set strand(value:IStrand):void
		{
			_strand = value;
			listModel = value.getBeadByType(ISelectionModel) as MenuModel;
			listView = value.getBeadByType(IListView) as IListView;
			(_strand as IEventDispatcher).addEventListener("itemAdded", handleItemAdded);
			(_strand as IEventDispatcher).addEventListener("itemRemoved", handleItemRemoved);
			loadBeadFromValuesManager(IKeyboardHandler, "iKeyboardHandler", _strand);
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
			sendStrandEvent(_strand,"change");
    }
		
		/**
		 * @royaleemitcoercion org.apache.royale.core.IIndexedItemRenderer
     * @royaleignorecoercion org.apache.royale.core.IRollOverModel
		 */
		protected function rolloverHandler(event:Event):void
		{
			var renderer:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (renderer) {
				IRollOverModel(listModel).rollOverIndex = renderer.index;
			}
		}
		
		/**
		  * @royaleemitcoercion org.apache.royale.core.IIndexedItemRenderer
      * @royaleignorecoercion org.apache.royale.core.IRollOverModel
      * @royaleignorecoercion org.apache.royale.core.ISelectableItemRenderer
		 */
		protected function rolloutHandler(event:Event):void
		{
			var renderer:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (renderer) {
				if (renderer is IStrand)
				{
					var selectionBead:ISelectableItemRenderer = (renderer as IStrand).getBeadByType(ISelectableItemRenderer) as ISelectableItemRenderer;
					if (selectionBead)
					{
						selectionBead.hovered = false;
						selectionBead.down = false;                        
					}
				}
				(listModel as IRollOverModel).rollOverIndex = -1;
			}
		}	

	}
}