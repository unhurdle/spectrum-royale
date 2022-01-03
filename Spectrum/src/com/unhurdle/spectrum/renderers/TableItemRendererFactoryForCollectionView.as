package com.unhurdle.spectrum.renderers
{
  
    import org.apache.royale.collections.ICollectionView;
    import org.apache.royale.core.IBead;
    import org.apache.royale.core.IChild;
    import org.apache.royale.core.IDataProviderItemRendererMapper;
    import org.apache.royale.core.IItemRendererClassFactory;
    import org.apache.royale.core.IListPresentationModel;
    import org.apache.royale.core.IParent;
    import org.apache.royale.core.ISelectableItemRenderer;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.EventDispatcher;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.html.beads.IListView;
		import com.unhurdle.spectrum.renderers.ITextItemRenderer;
   	import org.apache.royale.utils.loadBeadFromValuesManager;
    import com.unhurdle.spectrum.TableView;
    import com.unhurdle.spectrum.TBodyContentArea;
    import com.unhurdle.spectrum.model.TableModel;
    import com.unhurdle.spectrum.Table;
    import com.unhurdle.spectrum.TableColumn;
		import com.unhurdle.spectrum.TableHeaderCell;
    import com.unhurdle.spectrum.THead;
    import com.unhurdle.spectrum.TableRow;
		import org.apache.royale.collections.ArrayList;
    import org.apache.royale.html.beads.EasyDataProviderChangeNotifier;
    import com.unhurdle.spectrum.TextNode;
    import org.apache.royale.core.IItemRenderer;
    import com.unhurdle.spectrum.CheckBox;
    import org.apache.royale.core.IIndexedItemRenderer;
    import org.apache.royale.core.ILabelFieldItemRenderer;
  
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
		
			view = table.view as TableView;
			tbody = view.dataGroup as TBodyContentArea;
		
		
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
		private var isSorted:Boolean;
		
		private var tbody:TBodyContentArea;
		protected function dataProviderChangeHandler(event:Event):void
		{
		if (!model)
			return;
		var dp:ICollectionView = model.dataProvider as ICollectionView;
		if (!dp)
		{
			model.selectedIndex = -1;
			model.selectedItem = null;
			model.selectedItemProperty = null;
			tbody.removeAllItemRenderers();
			return;
		}
		tbody.removeAllItemRenderers();
		removeElements(view.thead);
		createHeader();
		// var presentationModel:IListPresentationModel = table.presentationModel as IListPresentationModel;
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
				
				if(column.multiSelect == true){
						// checkBoxRenderer(column,i,j,index,presentationModel);
				}
				else{
						if(column.itemRenderer != null)
    		{
					ir = column.itemRenderer.newInstance() as ITextItemRenderer;
    		}
				else
    		{
    		ir = itemRendererFactory.createItemRenderer() as ITextItemRenderer;
    		}
				
				labelField =  column.dataField;
				var item:Object = dp.getItemAt(i);
				(ir as DataItemRenderer).dataField = labelField;
				(ir as DataItemRenderer).rowIndex = i;
				(ir as DataItemRenderer).columnIndex = j;
		
			
				// fillRenderer(index++, item, (ir as ILabelFieldItemRenderer), presentationModel);
				}
			}
		(_strand as IEventDispatcher).dispatchEvent(new Event("itemsCreated"));
    table.dispatchEvent(new Event("layoutNeeded"));
				}
			
    }
	
		private function checkBoxRenderer(multiColumn:TableColumn,i:int,j:int,index:int,presentationModel:IListPresentationModel):void
		{
			
			var ir:IItemRenderer;
			if(multiColumn.itemRenderer != null)
    		{
					ir = multiColumn.itemRenderer.newInstance() as TableItemRenderer;
    		}
				else
    		{
    		ir = itemRendererFactory.createItemRenderer() as TableItemRenderer;
    		}
				var item:Object = model.dataProvider.getItemAt(i);
		
				(ir as DataItemRenderer).rowIndex = i;
				(ir as DataItemRenderer).columnIndex = j;
				COMPILE::JS
				{
				ir.element.classList.add("spectrum-Table-checkboxCell");
				ir.element.appendChild(checkBoxLabel());
				ir.element.addEventListener('click',indeterminate);
				}
				fillRenderer(index++, item, (ir as ILabelFieldItemRenderer), presentationModel);

			
		(_strand as IEventDispatcher).dispatchEvent(new Event("itemsCreated"));
    table.dispatchEvent(new Event("layoutNeeded"));
	}
		
		private function indeterminate(ev:Event):void
		{
			COMPILE::JS
			{
			var count:int = 0;
			for (var i:int = 0;i<ev.currentTarget.parentElement.parentElement.children.length;i++){
				var tr:Object = ev.currentTarget.parentElement.parentElement.children[i];
				for (var j:int = 0;j<tr.children.length;j++){
					var td:Object = tr.children[j];
					if(td.classList.contains('spectrum-Table-checkboxCell')){
						if(td.children[0].children[0].checked == true){
							count++;
						}
					}
				}
			}

			if(count > 0 && !headerRow.element.children[0].children[0].children[0].checked){
						headerRow.element.children[0].children[0].classList.toggle("is-indeterminate",true);
					}
					else{
						headerRow.element.children[0].children[0].classList.toggle("is-indeterminate",false);
						if(headerRow.element.children[0].children[0].children[0].checked){
								headerRow.element.children[0].children[0].children[0].checked == false;
								headerRow.element.children[0].children[0].classList.toggle("is-indeterminate",true);
							}
						}
				if(count == i){
					checkForAll(count, i);
				}
			}
		}
		
	
		private function checkForAll(count:int,i:int):void
		{
			COMPILE::JS
			{
				headerRow.element.children[0].children[0].classList.toggle("is-indeterminate",false);
				headerRow.element.children[0].children[0].children[0].checked = true;
			}
		}
	
		COMPILE::JS
		private function checkBoxLabel():HTMLElement
		{
		var checkBox:CheckBox = new CheckBox();
		return checkBox.element;
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
		itemRenderer:ILabelFieldItemRenderer,
		presentationModel:IListPresentationModel):void
		{
			tbody.addItemRendererAt(itemRenderer, index);
			itemRenderer.labelField = labelField;
		
			rendArray.push(itemRenderer);
			setData(itemRenderer, item, index);
		}

		private var rendArray:Array = [];
		protected function setData(itemRenderer:IIndexedItemRenderer, data:Object, index:int):void
		{
			COMPILE::JS
			{
			if(!itemRenderer.element.classList.contains("spectrum-Table-checkboxCell")){
			itemRenderer.data = data;
			}
		}
				itemRenderer.index = index;
		}

		private var sortArray:Array = [];
		
		private function checkToSort(rArray:Array):void
		{
			COMPILE::JS
			{
				//TODO better way to do this.
			for (var i:int = 0;i<headerRow.element.children.length;i++){
				if(headerRow.element.children[i].classList.contains('is-sortable')) {
					if(!isSorted){ //ascending A-Z
						// table.dataProvider = sortByColumn(i,true);
						isSorted = true;
					}
					else{
					//descending - Z-A
						// table.dataProvider = sortByColumn(i,false);
						isSorted = false;
					}
	
					table.addBead(new EasyDataProviderChangeNotifier());
					dataProviderChangeHandler(null);
					return;
					}						
				}
			}
		}

		private function sortByColumn(idx:int,ascending:Boolean):ArrayList{
		// var column:TableColumn = table.columns[idx];
		// var property:String = column.dataField;
		var arr:ArrayList;
		// if(table.dataProvider is ArrayList){
			// arr = table.dataProvider as ArrayList;
		// } else {
			// arr = table.dataProvider.source;
		// }
		arr.source.sort(sortItem);
		if(ascending){
			isSorted = true;
		}else{
			ascending = false;
		}
		return arr;
		function sortItem(a:Object,b:Object):int{
			var result:int;
			// if(a[property] > b[property]){
			// 	return ascending ? 1 : -1;
			// } 
			// if(a[property] < b[property]){
			// 	return ascending ? -1 : 1;
			// }
			// return 0;
		}
	}

	private var tableHeader:TableHeaderCell;
	private var headerRow:TableRow;

	
	private function multiSelectHeader():void
	{
		COMPILE::JS{
		tableHeader= new TableHeaderCell();
		tableHeader.element.classList.add("spectrum-Table-checkboxCell");

		var checkBox:CheckBox = new CheckBox();
		tableHeader.addElement(checkBox);
		tableHeader.addEventListener('click',checkBoxClick);
		}
	}

		private function checkBoxClick(event:Event):void
		{
			if(event.currentTarget.element.children){
			for each(var c:Object in event.currentTarget.element.children ){
				if(c.classList.contains("spectrum-Checkbox")){
				
					if(c.children[0].checked == true){
						c.classList.remove('is-indeterminate');
						setAllColumnsToChecked(c,true);
						return;
					}
					else{
						setAllColumnsToChecked(c,false);
						return;
					}
				}
			}
		}
	}

	private function setAllColumnsToChecked(checked:Object,boolean:Boolean):void
	{
		COMPILE::JS
		{
		for each (var row:Object in table.element.children[1].children){
			if(row.children){
				if(boolean){
					row.children[0].children[0].children[0].checked = true;
				}
				else{
					row.children[0].children[0].children[0].checked = false;
					}
				}
			}
		}
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
		if(createHeaderRow) 
		{
			if(view.thead == null)
				view.thead = new THead();
				var thead:THead = view.thead;
					
			
			headerRow = new TableRow();
			for(c=0; c < model.columns.length; c++)
			{
				test = model.columns[c] as TableColumn;
				if((model.columns[c] as TableColumn).multiSelect){
					multiSelectHeader();
				}
				else{
					tableHeader = new TableHeaderCell();
				}
				
			
				COMPILE::JS
				{
					if(test.sortable == true){
						tableHeader.sortable = true;
						tableHeader.addEventListener('click',checkToSort);
						if(isSorted){
							tableHeader.toggle("is-sorted-asc",true);
							tableHeader.toggle("is-sorted-desc",false);
							tableHeader.setAttribute('aria-sort','ascending');
						}
						else {
							tableHeader.toggle("is-sorted-asc",false);
							tableHeader.toggle("is-sorted-desc",true);
							
							tableHeader.element.classList.add("is-sorted-desc");
							tableHeader.element.setAttribute('aria-sort','descending');
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
				COMPILE::JS
				{
				this.table.element.insertBefore(thead.element,tbody.element);
				}
			}
		}
	}
}