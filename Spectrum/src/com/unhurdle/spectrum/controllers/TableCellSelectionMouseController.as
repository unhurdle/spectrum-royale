package com.unhurdle.spectrum.controllers
{
  
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.IItemRendererOwnerView;
	import org.apache.royale.core.IRollOverModel;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IBeadView;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.ItemAddedEvent;
	import org.apache.royale.events.ItemClickedEvent;
	import org.apache.royale.events.ItemRemovedEvent;
	import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.TableView;
  import com.unhurdle.spectrum.model.TableModel;


  
	public class TableCellSelectionMouseController implements IBeadController
	{
    public function TableCellSelectionMouseController()
		{
		}
		
      protected var model:ISelectionModel;

        protected var view:TableView;

        protected var dataGroup:IItemRendererOwnerView;

		private var _strand:IStrand;
		
    public function set strand(value:IStrand):void
		{
			_strand = value;
			model = value.getBeadByType(ISelectionModel) as ISelectionModel;
			view = value.getBeadByType(IBeadView) as TableView;
			IEventDispatcher(_strand).addEventListener("itemAdded", handleItemAdded);
			IEventDispatcher(_strand).addEventListener("itemRemoved", handleItemRemoved);
		}
		
    protected function handleItemAdded(event:ItemAddedEvent):void
		{
			IEventDispatcher(event.item).addEventListener("itemClicked", selectedHandler);
			IEventDispatcher(event.item).addEventListener("itemRollOver", rolloverHandler);
			IEventDispatcher(event.item).addEventListener("itemRollOut", rolloutHandler);
		}
		
    protected function handleItemRemoved(event:ItemRemovedEvent):void
		{
      IEventDispatcher(event.item).removeEventListener("itemClicked", selectedHandler);
			IEventDispatcher(event.item).removeEventListener("itemRollOver", rolloverHandler);
			IEventDispatcher(event.item).removeEventListener("itemRollOut", rolloutHandler);
		}
		
		protected function selectedHandler(event:ItemClickedEvent):void
        {
            var renderer:DataItemRenderer = event.currentTarget as DataItemRenderer;
						model.labelField = renderer.labelField;
						if(!event.target.element.classList.contains("spectrum-Table-checkboxCell")){
							
						model.selectedItem = event.data;
            (model as TableModel).selectedItemProperty = model.selectedItem[model.labelField];
            model.selectedIndex = (model as TableModel).getIndexForSelectedItemProperty();
						}

            view.host.dispatchEvent(new Event(Event.CHANGE));
        }
		
		protected function rolloverHandler(event:Event):void
		{
			var renderer:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (renderer) {
				(model as IRollOverModel).rollOverIndex = renderer.index;
			}
		}
		
		protected function rolloutHandler(event:Event):void
		{
			var renderer:ISelectableItemRenderer = event.currentTarget as ISelectableItemRenderer;
			if (renderer) {
				renderer.hovered = false;
				renderer.down = false;
				(model as IRollOverModel).rollOverIndex = -1;
			}
		}
	
	}
}