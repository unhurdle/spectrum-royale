package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.core.IBead;
	import org.apache.royale.core.UIBase;
	import org.apache.royale.core.IDataProviderModel;
  import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.CollectionEvent;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.html.beads.IListView;
  import com.unhurdle.spectrum.model.TableModel;
	import com.unhurdle.spectrum.TableRow;
	import com.unhurdle.spectrum.TableCell;
	
  public class UpdateTableRowForArrayListData implements IBead
  {
    public function UpdateTableRowForArrayListData()
    {
      
    }

    protected var _strand:IStrand;
		public function set strand(value:IStrand):void
		{
			_strand = value;
			(value as IEventDispatcher).addEventListener("initComplete", initComplete);
		}

    protected var labelField:String;
		
		protected var model:TableModel;

		protected function initComplete(event:Event):void
		{
			(_strand as IEventDispatcher).removeEventListener("initComplete", initComplete);
			
			model = _strand.getBeadByType(ISelectionModel) as TableModel;
			labelField = model.labelField;

			model.addEventListener("dataProviderChanged", dataProviderChangeHandler);

			dataProviderChangeHandler(null);
		}
		
		private var dp:IEventDispatcher;
		protected function dataProviderChangeHandler(event:Event):void
		{
		
				if(dp)
			{
				dp.removeEventListener(CollectionEvent.ITEM_UPDATED, handleItemUpdated);
			}
			dp = model.dataProvider as IEventDispatcher;
			if (!dp)
				return;
			
			dp.addEventListener(CollectionEvent.ITEM_UPDATED, handleItemUpdated);
			}
		
	

		protected function handleItemUpdated(event:CollectionEvent):void
		{
			var ir:ISelectableItemRenderer;
			var processedRow:TableRow = (itemRendererParent as UIBase).getElementAt(event.index) as TableRow;
			var cell:TableCell;
			// var cell:TableItemRenderer;
			var n:int = processedRow.numElements;

			for (var i:int = 0; i < n; i++)
			{
				cell = processedRow.getElementAt(i) as TableCell;
				// cell = processedRow.getElementAt(i) as TableItemRenderer;
				ir = cell.getElementAt(0) as ISelectableItemRenderer;
				setData(ir, event.item, event.index);
			}
			
			(_strand as IEventDispatcher).dispatchEvent(new Event("layoutNeeded"));
		}

		private var _itemRendererParent: IItemRendererParent;

		public function get itemRendererParent():IItemRendererParent
		{
			if (_itemRendererParent == null) {
				var listView:IListView = _strand.getBeadByType(IListView) as IListView;
				_itemRendererParent = listView.dataGroup;
			}
			return _itemRendererParent;
		}

    protected function setData(itemRenderer:ISelectableItemRenderer, data:Object, index:int):void
    {
      itemRenderer.index = index;
      itemRenderer.data = data;
    }
  }
}