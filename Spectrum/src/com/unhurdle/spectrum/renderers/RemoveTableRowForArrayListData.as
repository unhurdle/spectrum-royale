package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.core.IBead;
	import org.apache.royale.core.UIBase;
	import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.CollectionEvent;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.html.supportClasses.DataItemRenderer;
	import org.apache.royale.html.beads.IListView;
	import org.apache.royale.core.IItemRenderer;
	import com.unhurdle.spectrum.TableCell;
	import com.unhurdle.spectrum.TableRow;
	import com.unhurdle.spectrum.model.TableModel;

	public class RemoveTableRowForArrayListData implements IBead
	{
		public function RemoveTableRowForArrayListData()
		{
		}

		private var _strand:IStrand;
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
				dp.removeEventListener(CollectionEvent.ITEM_REMOVED, handleItemRemoved);
			}
			dp = model.dataProvider as IEventDispatcher;
			if (!dp)
				return;
			
			dp.addEventListener(CollectionEvent.ITEM_REMOVED, handleItemRemoved);
		}

		protected function handleItemRemoved(event:CollectionEvent):void
		{
			var ir:DataItemRenderer;
			var cell:TableCell;
			var processedRow:TableRow = (itemRendererParent as UIBase).getElementAt(event.index) as TableRow;
			while (processedRow.numElements > 0) {
				cell = processedRow.getElementAt(0) as TableCell;
				ir = cell.getElementAt(0) as DataItemRenderer;
				itemRendererParent.removeItemRenderer(ir);
				cell.removeElement(ir);
				processedRow.removeElement(cell);
			}
			(itemRendererParent as UIBase).removeElement(processedRow);

			// adjust the itemRenderers' index to adjust for the shift
			var len:int = itemRendererParent.numItemRenderers;
			for (var i:int = event.index; i < len; i++)
			{
				ir = itemRendererParent.getItemRendererAt(i) as DataItemRenderer;
				ir.index = i;
				ir.rowIndex = i;
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
	}
}
