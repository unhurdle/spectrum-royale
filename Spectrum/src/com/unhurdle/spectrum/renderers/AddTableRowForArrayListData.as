package com.unhurdle.spectrum.renderers
{

	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IItemRendererClassFactory;
	import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.core.IListPresentationModel;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IStrandWithModelView;
	import org.apache.royale.core.SimpleCSSStyles;
	import org.apache.royale.core.UIBase;
	import org.apache.royale.events.CollectionEvent;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import com.unhurdle.spectrum.model.TableModel;
	import com.unhurdle.spectrum.renderers.TableItemRenderer;
	import com.unhurdle.spectrum.TableCell;
	import com.unhurdle.spectrum.TableColumn;
	import com.unhurdle.spectrum.TableRow;
	import com.unhurdle.spectrum.Table;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.html.beads.IListView;
	import org.apache.royale.events.ValueEvent;


	public class AddTableRowForArrayListData implements IBead
	{
	
		public function AddTableRowForArrayListData()
		{
			
		}
		
		protected var _strand:IStrand;
	
		public function set strand(value:IStrand):void
		{
			_strand = value;
			table = value as Table;
			IEventDispatcher(value).addEventListener("initComplete", initComplete);

		}

  	protected var labelField:String;
		
		protected var model:TableModel;

		protected var table:Table;

	
		protected function initComplete(event:Event):void
		{
			IEventDispatcher(_strand).removeEventListener("initComplete", initComplete);
			
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
				dp.removeEventListener(CollectionEvent.ITEM_ADDED, handleItemAdded);
			}
			dp = model.dataProvider as IEventDispatcher;
			if (!dp)
				return;
			
			// listen for individual items being added in the future.
			dp.addEventListener(CollectionEvent.ITEM_ADDED, handleItemAdded);
		}
		protected function handleItemAdded(event:CollectionEvent):void
	
		{
      var presentationModel:IListPresentationModel = _strand.getBeadByType(IListPresentationModel) as IListPresentationModel;
			var column:TableColumn;
			var ir:TableItemRenderer;

			var index:int = event.index * model.columns.length;
			for(var j:int = 0; j < model.columns.length; j++)
			{
				column = model.columns[j] as TableColumn;
				
				if(column.itemRenderer != null)
				{
					ir = column.itemRenderer.newInstance() as TableItemRenderer;
				} else
				{
					ir = itemRendererFactory.createItemRenderer(itemRendererParent) as TableItemRenderer;
				}
	
				labelField =  column.dataField;
				
		
				ir.dataField = labelField;
				ir.rowIndex = event.index;
				ir.columnIndex = j;
		
				fillRenderer(index++, event.item, ir, presentationModel);
			}

			// update the index values in the itemRenderers to correspond to their shifted positions.
			// adjust the itemRenderers' index to adjust for the shift
			var len:int = itemRendererParent.numItemRenderers;
			for (var i:int = event.index; i < len; i++)
			{
				ir = itemRendererParent.getItemRendererAt(i) as TableItemRenderer;
				ir.index = i;
				ir.rowIndex = i;
			}

			(_strand as IEventDispatcher).dispatchEvent(new Event("layoutNeeded"));
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

        private var _itemRendererFactory:IItemRendererClassFactory;

        public function get itemRendererFactory():IItemRendererClassFactory
        {
            if(!_itemRendererFactory)
                _itemRendererFactory = loadBeadFromValuesManager(IItemRendererClassFactory, "iItemRendererClassFactory", _strand) as IItemRendererClassFactory;

            return _itemRendererFactory;
        }

        protected function fillRenderer(index:int,
                                        item:Object,
                                        itemRenderer:TableItemRenderer,
                                        presentationModel:IListPresentationModel):void
        {
            itemRendererParent.addItemRendererAt(itemRenderer, index);

            itemRenderer.labelField = labelField;

            setData(itemRenderer, item, index);
        }

   
        protected function setData(itemRenderer:TableItemRenderer, data:Object, index:int):void
        {
            itemRenderer.index = index;
            itemRenderer.data = data;
        }
	}
}
