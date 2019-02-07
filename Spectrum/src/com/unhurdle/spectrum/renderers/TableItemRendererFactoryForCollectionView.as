package com.unhurdle.spectrum.renderers
{
  
    import org.apache.royale.collections.ICollectionView;
    import org.apache.royale.core.IBead;
    import org.apache.royale.core.IBeadModel;
    import org.apache.royale.core.IChild;
    import org.apache.royale.core.IDataProviderItemRendererMapper;
    import org.apache.royale.core.IDataProviderModel;
    import org.apache.royale.core.IItemRendererClassFactory;
    import org.apache.royale.core.IListPresentationModel;
    import org.apache.royale.core.IParent;
    import org.apache.royale.core.ISelectableItemRenderer;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.SimpleCSSStyles;
    import org.apache.royale.core.UIBase;
    import org.apache.royale.events.CollectionEvent;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.EventDispatcher;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.html.beads.IListView;
    import org.apache.royale.html.supportClasses.DataItemRenderer;
    import org.apache.royale.jewel.beads.itemRenderers.ITextItemRenderer;
   	import org.apache.royale.utils.loadBeadFromValuesManager;
    import com.unhurdle.spectrum.TableView;
    import com.unhurdle.spectrum.TBodyContentArea;
    import com.unhurdle.spectrum.model.TableModel;
    import com.unhurdle.spectrum.Table;
    import com.unhurdle.spectrum.TableColumn;
    import org.apache.royale.jewel.beads.controls.TextAlign;
    import com.unhurdle.spectrum.Label;
    import com.unhurdle.spectrum.TableHeaderCell;
    import com.unhurdle.spectrum.THead;
    import com.unhurdle.spectrum.TableRow;
    

   public class TableItemRendererFactoryForCollectionView extends EventDispatcher implements IBead, IDataProviderItemRendererMapper
	{
		public function TableItemRendererFactoryForCollectionView(target:Object = null)
		{
			super(target);
		}

	protected var _strand:IStrand;
		
	public function set strand(value:IStrand):void
		{
			_strand = value;
			table = value as Table;
			(value as IEventDispatcher).addEventListener("initComplete", initComplete);
		}

		protected function initComplete(event:Event):void
		{
			(_strand as IEventDispatcher).removeEventListener("initComplete", initComplete);

			view = _strand.getBeadByType(IListView) as TableView;
			tbody = view.dataGroup as TBodyContentArea;
			trace(1);
			trace(tbody);

            model = table.model as TableModel;
			model.addEventListener("dataProviderChanged", dataProviderChangeHandler);
			
			dataProviderChangeHandler(null);
		}
		
		protected var labelField:String;
		
		private var _itemRendererFactory:IItemRendererClassFactory;
		
	public function get itemRendererFactory():IItemRendererClassFactory
		{
			if(!_itemRendererFactory)
				_itemRendererFactory = loadBeadFromValuesManager(IItemRendererClassFactory, "iItemRendererClassFactory", _strand) as IItemRendererClassFactory;
			
			return _itemRendererFactory;
		}
		
		public function set itemRendererFactory(value:IItemRendererClassFactory):void
		{
			_itemRendererFactory = value;
		}

        protected var view:TableView;
        protected var model:TableModel;
        protected var table:Table;

		private var tbody:TBodyContentArea;
		protected function dataProviderChangeHandler(event:Event):void
		{
			// -- 1) CLEANING PHASE
            if (!model)
				return;
			var dp:ICollectionView = model.dataProvider as ICollectionView;
			if (!dp)
			{
				model.selectedIndex = -1;
				model.selectedItem = null;
				model.selectedItemProperty = null;

				// TBodyContentArea - remove data items
				tbody.removeAllItemRenderers();
				return;
			}
			// remove this and better add beads when needed
			// listen for individual items being added in the future.
			// var dped:IEventDispatcher = dp as IEventDispatcher;
			// dped.addEventListener(CollectionEvent.ITEM_ADDED, itemAddedHandler);
			// dped.addEventListener(CollectionEvent.ITEM_REMOVED, itemRemovedHandler);
			// dped.addEventListener(CollectionEvent.ITEM_UPDATED, itemUpdatedHandler);
			
       // TBodyContentArea - remove data items
			tbody.removeAllItemRenderers();
			
      // THEAD - remove header items
			removeElements(view.thead);
      createHeader();
			
			
		
			var presentationModel:IListPresentationModel = table.presentationModel as IListPresentationModel;
			
			labelField = model.labelField;
			
            var column:TableColumn;
            var ir:ITextItemRenderer;

			var n:int = dp.length;
			var index:int = 0;
			for (var i:int = 0; i < n; i++)
			{
				// var current:Object = dp[i];
			    for(var j:int = 0; j < model.columns.length; j++)
				{
			        column = model.columns[j] as TableColumn;
					
			        if(column.itemRenderer != null)
                    {
						ir = column.itemRenderer.newInstance() as ITextItemRenderer;
                    } else
                    {
                        ir = itemRendererFactory.createItemRenderer(tbody) as ITextItemRenderer;
                    }

					labelField =  column.dataField;
                    var item:Object = dp.getItemAt(i);

                    (ir as DataItemRenderer).dataField = labelField;
					(ir as DataItemRenderer).rowIndex = i;
					(ir as DataItemRenderer).columnIndex = j;
                    fillRenderer(index++, item, (ir as ISelectableItemRenderer), presentationModel);
			
                    if(column.align != "")
                    {
                        ir.align = column.align;
                    }
                }
			}
			
			(_strand as IEventDispatcher).dispatchEvent(new Event("itemsCreated"));
            table.dispatchEvent(new Event("layoutNeeded"));
        }

		public function removeElements(container: IParent):void
		{
			if(container != null)
			{
				while (container.numElements > 0) {
					var child:IChild = container.getElementAt(0);
					container.removeElement(child);
				}
			}
		}

		protected function fillRenderer(index:int,
    item:Object,
    itemRenderer:ISelectableItemRenderer,
    presentationModel:IListPresentationModel):void
		{
			trace(2);
			trace(tbody);
			tbody.addItemRendererAt(itemRenderer, index);
			itemRenderer.labelField = labelField;
			
			if (presentationModel) {
				var style:SimpleCSSStyles = new SimpleCSSStyles();
				style.marginBottom = presentationModel.separatorThickness;
				(itemRenderer as UIBase).style = style;
				(itemRenderer as UIBase).height = presentationModel.rowHeight;
				(itemRenderer as UIBase).percentWidth = 100;
			}
			
			setData(itemRenderer, item, index);
		}

	
		protected function setData(itemRenderer:ISelectableItemRenderer, data:Object, index:int):void
		{
			itemRenderer.index = index;
			itemRenderer.data = data;
		}

        private function createHeader():void
		{
            var createHeaderRow:Boolean = false;
            var test:TableColumn;
            var c:int;

			for(c=0; c < model.columns.length; c++)
			{
				test = model.columns[c] as TableColumn;
				if (test.label != null) {
					createHeaderRow = true;
					break;
				}
			}

            if (createHeaderRow) 
            {
				if(view.thead == null)
                	view.thead = new THead();
				var thead:THead = view.thead;
				var headerRow:TableRow = new TableRow();
				
				for(c=0; c < model.columns.length; c++)
				{
					test = model.columns[c] as TableColumn;
					var tableHeader:TableHeaderCell = new TableHeaderCell();
					
                    var label:Label = new Label();
					tableHeader.addElement(label);
					label.text = test.label == null ? "" : test.label;
					
					var columnLabelTextAlign:TextAlign = new TextAlign();
					columnLabelTextAlign.align = test.columnLabelAlign;
					label.addBead(columnLabelTextAlign);
					headerRow.addElement(tableHeader);
				}

				thead.addElement(headerRow);
				table.addElement(thead);
			}
        }

		
		// protected function itemAddedHandler(event:CollectionEvent):void
		// {
		// }

		
		// protected function itemRemovedHandler(event:CollectionEvent):void
		// {
		// }

		// protected function itemUpdatedHandler(event:CollectionEvent):void
		// {
		// }
    }
}