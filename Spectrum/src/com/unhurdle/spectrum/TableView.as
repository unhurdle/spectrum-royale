package com.unhurdle.spectrum
{
  
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import com.unhurdle.spectrum.model.TableModel;
	import com.unhurdle.spectrum.THead;
	import com.unhurdle.spectrum.TFoot;



	 
	public class TableView extends ListViewForTable
	{

		public function TableView()
		{
			super();
        }

	
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
		}

		protected var model:TableModel;

	
		override protected function handleInitComplete(event:Event):void
		{
			model = _strand.getBeadByType(TableModel) as TableModel;
			model.addEventListener("selectedIndexChanged", selectionChangeHandler);
			model.addEventListener("rollOverIndexChanged", rollOverIndexChangeHandler);
			IEventDispatcher(_strand).addEventListener("itemsCreated", itemsCreatedHandler);

			super.handleInitComplete(event);
		}

		override protected function itemsCreatedHandler(event:Event):void
		{
      super.itemsCreatedHandler(event);
			if(listModel.selectedIndex != -1)
				selectionChangeHandler(null);
		}


		public var thead:THead;


		public var tfoot:TFoot;

		override protected function selectionChangeHandler(event:Event):void
		{
			var ir:ISelectableItemRenderer = dataGroup.getItemRendererAt(lastSelectedIndex) as ISelectableItemRenderer;
            if (ir)
				ir.selected = false;
			
			ir = dataGroup.getItemRendererAt(listModel.selectedIndex) as ISelectableItemRenderer;
			if (ir)
				ir.selected = true;
            lastSelectedIndex = listModel.selectedIndex;
		}
	}


}