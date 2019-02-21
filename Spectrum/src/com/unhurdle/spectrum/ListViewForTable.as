package com.unhurdle.spectrum
{
  import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.core.ILayoutView;
	import org.apache.royale.core.IRollOverModel;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.html.beads.DataContainerView;

	COMPILE::JS
	public class ListViewForTable extends DataContainerView
	{
		public function ListViewForTable()
		{
			super();
		}

		override public function set strand(value:IStrand):void
		{
			super.strand = value;

		}
		private var _dataGroup:IItemRendererParent;
		
		override public function get dataGroup():IItemRendererParent
		{
			if(!_dataGroup)
			{
				var c:ILayoutView = contentView;
				if(c && c is IItemRendererParent)
					_dataGroup = c as IItemRendererParent;
				else
					_dataGroup = super.dataGroup;
			}
			return _dataGroup;
		}


		protected var listModel:ISelectionModel;

		protected var lastSelectedIndex:int = -1;

		override protected function handleInitComplete(event:Event):void
		{
			listModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
			listModel.addEventListener("selectionChanged", selectionChangeHandler);
			listModel.addEventListener("rollOverIndexChanged", rollOverIndexChangeHandler);
			(_strand as IEventDispatcher).addEventListener("itemsCreated", itemsCreatedHandler);

			super.handleInitComplete(event);
		}

		override protected function itemsCreatedHandler(event:Event):void
		{
      super.itemsCreatedHandler(event);
			if(listModel.selectedIndex != -1)
				selectionChangeHandler(null);
		}

		protected function selectionChangeHandler(event:Event):void
		{
			var ir:ISelectableItemRenderer = dataGroup.getItemRendererAt(lastSelectedIndex) as ISelectableItemRenderer;
			if(ir)
				ir.selected = false;
			ir = dataGroup.getItemRendererAt(listModel.selectedIndex) as ISelectableItemRenderer;
			if(ir)
				ir.selected = true;

			lastSelectedIndex = listModel.selectedIndex;
		}

		protected var lastRollOverIndex:int = -1;

		protected function rollOverIndexChangeHandler(event:Event):void
		{
			var ir:ISelectableItemRenderer = dataGroup.getItemRendererAt(lastRollOverIndex) as ISelectableItemRenderer;
			if(ir)
				ir.hovered = false;
			ir = dataGroup.getItemRendererAt((listModel as IRollOverModel).rollOverIndex) as ISelectableItemRenderer;
			if(ir)
				ir.hovered = true;
			lastRollOverIndex = (listModel as IRollOverModel).rollOverIndex;
		}
	}

	COMPILE::SWF
	public class ListViewForTable extends DataContainerView
	{
		public function ListViewForTable()
		{
			super();
		}

		protected var listModel:ISelectionModel;

		override public function set strand(value:IStrand):void
		{
			_strand = value;
			super.strand = value;
		}
		private var _dataGroup:IItemRendererParent;
		override public function get dataGroup():IItemRendererParent
		{
			if(!_dataGroup)
			{
				var c:ILayoutView = contentView;
				if(c && c is IItemRendererParent)
					_dataGroup = c as IItemRendererParent;
				else
					_dataGroup = super.dataGroup;
			}
			return _dataGroup;
		}

		override protected function handleInitComplete(event:Event):void
		{
			super.handleInitComplete(event);

			listModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
			listModel.addEventListener("selectionChanged", selectionChangeHandler);
			listModel.addEventListener("rollOverIndexChanged", rollOverIndexChangeHandler);
		}

		protected var lastSelectedIndex:int = -1;

		protected function selectionChangeHandler(event:Event):void
		{
			var ir:ISelectableItemRenderer = dataGroup.getItemRendererAt(lastSelectedIndex) as ISelectableItemRenderer;
            if (ir)
				ir.selected = false;
			ir = dataGroup.getItemRendererAt(listModel.selectedIndex) as ISelectableItemRenderer;
			if (ir)
				ir.selected = true;
            lastSelectedIndex = listModel.selectedIndex;
		}

		protected var lastRollOverIndex:int = -1;

		protected function rollOverIndexChangeHandler(event:Event):void
		{
			var ir:ISelectableItemRenderer = dataGroup.getItemRendererAt(lastRollOverIndex) as ISelectableItemRenderer;
			if(ir)
				ir.hovered = false;
			
			ir = dataGroup.getItemRendererAt(IRollOverModel(listModel).rollOverIndex) as IRollOverModel as ISelectableItemRenderer;
			if(ir)
				ir.hovered = true;

			lastRollOverIndex = (listModel as IRollOverModel).rollOverIndex;
		}
	}
}