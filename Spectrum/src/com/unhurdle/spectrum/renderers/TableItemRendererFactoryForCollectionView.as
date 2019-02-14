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
		import com.unhurdle.spectrum.renderers.ITextItemRenderer;
   	import org.apache.royale.utils.loadBeadFromValuesManager;
    import com.unhurdle.spectrum.TableView;
    import com.unhurdle.spectrum.TBodyContentArea;
    import com.unhurdle.spectrum.model.TableModel;
    import com.unhurdle.spectrum.Table;
    import com.unhurdle.spectrum.TableColumn;
		import com.unhurdle.spectrum.Label;
    import com.unhurdle.spectrum.TableHeaderCell;
    import com.unhurdle.spectrum.THead;
    import com.unhurdle.spectrum.TableRow;

    import org.apache.royale.collections.ArrayList;
    import org.apache.royale.html.beads.EasyDataProviderChangeNotifier;
    import com.unhurdle.spectrum.TextNode;
   
 
    

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
		
		
			model = table.model as TableModel;
			model.addEventListener("dataProviderChanged", dataProviderChangeHandler);
			// model.addEventListener('click',)
			
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
		private var isSorted:Boolean;
		
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
					// labelField = tableHeader.dataField; //messes up the rend.
          	var item:Object = dp.getItemAt(i);

           	(ir as DataItemRenderer).dataField = labelField;
						(ir as DataItemRenderer).rowIndex = i;
						(ir as DataItemRenderer).columnIndex = j;
            fillRenderer(index++, item, (ir as ISelectableItemRenderer), presentationModel);
			
                    // if(column.align != "")
                    // {
                    //     ir.align = column.align;
                    // }
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
			tbody.addItemRendererAt(itemRenderer, index);
			itemRenderer.labelField = labelField;
			
			if (presentationModel) {
				var style:SimpleCSSStyles = new SimpleCSSStyles();
				style.marginBottom = presentationModel.separatorThickness;
				(itemRenderer as UIBase).style = style;
				(itemRenderer as UIBase).height = presentationModel.rowHeight;
				(itemRenderer as UIBase).percentWidth = 100;
			}
			rendArray.push(itemRenderer);
			setData(itemRenderer, item, index);
		

		}
	
		private var rendArray:Array = [];
		protected function setData(itemRenderer:ISelectableItemRenderer, data:Object, index:int):void
		{
			
			itemRenderer.index = index;
			itemRenderer.data = data;
		
		}
		private var sortArray:Array = [];
		
		private function checkToSort(rArray:Array):void
		{
		COMPILE::JS
			{
		
						for (var i:int = 0;i<headerRow.element.children.length;i++){
							if(headerRow.element.children[i].classList.contains('is-sortable')) {
								if(!isSorted){ //ascending A-Z
									table.dataProvider = sortByColumn(i,true);
									isSorted = true;
									ascArrow(headerRow.element.children[i]);
			
								}
								
								else{
								//descending - Z-A
									table.dataProvider = sortByColumn(i,false);
									isSorted = false;
									descArrow(headerRow.element.children[i]);
							
							
								}
					
							table.addBead(new EasyDataProviderChangeNotifier());
							dataProviderChangeHandler(null);
							return;
				
						}						
					}

			
				}
			}


		COMPILE::JS
			
		private function ascArrow(tableHead:Object):void
		{
		
			if(tableHead.classList.contains("is-sorted-desc")){
				tableHead.classList.replace("is-sorted-desc","is-sorted-asc");
				tableHead.removeAttribute('aria-sort');//maybe dx need
				
			}
			else{
				tableHead.classList.add("is-sorted-asc");
			}
			tableHead.setAttribute('aria-sort','ascending');
		}
		COMPILE::JS
		

		private function descArrow(tableHead:Object):void
		{
			if(tableHead.classList.contains("is-sorted-asc")){
				tableHead.classList.replace("is-sorted-asc","is-sorted-desc");
				tableHead.removeAttribute('aria-sort');//maybe dx need
			}
			else{
				tableHead.classList.add("is-sorted-desc");
			}
			tableHead.setAttribute('aria-sort','descending');
			}
		

		private function sortByColumn(idx:int,ascending:Boolean):ArrayList{
		var column:TableColumn = table.columns[idx];
		var property:String = column.dataField;
		var arr:ArrayList;
		if(table.dataProvider is ArrayList){
			arr = table.dataProvider as ArrayList;
		} else {
			arr = table.dataProvider.source;
		}
		arr.source.sort(sortItem);
		if(ascending){
			isSorted = true;
		}else{
			ascending = false;
		}
		return arr;
		function sortItem(a:Object,b:Object):int{
			var result:int;
			if(a[property] > b[property]){
				return ascending ? 1 : -1;
			} 
			if(a[property] < b[property]){
				return ascending ? -1 : 1;
			}
			return 0;
		}
	}

	private var tableHeader:TableHeaderCell;
	private var headerRow:TableRow;
	
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
		if(createHeaderRow) 
		{
			if(view.thead == null)
				view.thead = new THead();
				var thead:THead = view.thead;
					
			
			headerRow = new TableRow();
			for(c=0; c < model.columns.length; c++)
			{
				test = model.columns[c] as TableColumn;
				
				tableHeader = new TableHeaderCell();
			
				
				
				
				COMPILE::JS
				{
					if(test.sortable == true){
						tableHeader.sortable = true;
						tableHeader.addEventListener('click',checkToSort);
						COMPILE::JS
			{
					if(isSorted){
						
						tableHeader.element.classList.add("is-sorted-asc");
						tableHeader.element.setAttribute('aria-sort','ascending');
						
					}
					else if(isSorted == false){
						// descArrow(tableHeader);
						tableHeader.element.classList.add("is-sorted-desc");
						tableHeader.element.setAttribute('aria-sort','descending');
					}
			}
				}
			}
			COMPILE::JS
			{
				var textNode:TextNode = new TextNode('');
				textNode.element = tableHeader.element;
				textNode.text = test.label == null ? "" : test.label;
			}

				(headerRow.element as HTMLElement).appendChild(tableHeader.element as HTMLElement);
			}

				thead.addElement(headerRow);
				table.addElement(thead);
		}
			}
		}
}