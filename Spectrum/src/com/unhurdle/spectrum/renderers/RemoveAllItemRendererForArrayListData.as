package com.unhurdle.spectrum.renderers
{

	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IDataProviderModel;
	import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IStrandWithModelView;
	import org.apache.royale.events.CollectionEvent;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.html.beads.IListView;

	public class RemoveAllItemRendererForArrayListData implements IBead
	{
	public function RemoveAllItemRendererForArrayListData()
		{
		}

		private var _strand:IStrand;

		public function set strand(value:IStrand):void
		{
			_strand = value;
			(value as IEventDispatcher).addEventListener("initComplete", initComplete);
		}
		
		protected function initComplete(event:Event):void
		{
		(_strand as IEventDispatcher).removeEventListener("initComplete", initComplete);
			
			_dataProviderModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
			dataProviderModel.addEventListener("dataProviderChanged", dataProviderChangeHandler);	
			
			// invoke now in case "dataProviderChanged" has already been dispatched.
			dataProviderChangeHandler(null);
		}
		
		private var dp:IEventDispatcher;
	
    protected function dataProviderChangeHandler(event:Event):void
		{
			if(dp)
			{
				dp.removeEventListener(CollectionEvent.ALL_ITEMS_REMOVED, handleAllItemsRemoved);
			}
			dp = dataProviderModel.dataProvider as IEventDispatcher;
			if (!dp)
				return;
			
			// listen for all items being removed in the future.
			dp.addEventListener(CollectionEvent.ALL_ITEMS_REMOVED, handleAllItemsRemoved);
		}

		protected function handleAllItemsRemoved(event:CollectionEvent):void
		{
			if (dataProviderModel is ISelectionModel)
			{
				var model:ISelectionModel = dataProviderModel as ISelectionModel;
				model.selectedIndex = -1;
				model.selectedItem = null;
			}

			itemRendererParent.removeAllItemRenderers();
			(_strand as IEventDispatcher).dispatchEvent(new Event("layoutNeeded"));
		}

		private var _dataProviderModel: IDataProviderModel;

		public function get dataProviderModel(): IDataProviderModel
		{
			if (_dataProviderModel == null) {
				_dataProviderModel = _strand.getBeadByType(IDataProviderModel) as IDataProviderModel;
			}
			return _dataProviderModel;
		}

		private var _itemRendererParent: IItemRendererParent;

		public function get itemRendererParent():IItemRendererParent
		{
			if (_itemRendererParent == null) {
				var view:IListView = (_strand as IStrandWithModelView).view as IListView;
				_itemRendererParent = view.dataGroup;
			}
			return _itemRendererParent;
		}
	}
}


