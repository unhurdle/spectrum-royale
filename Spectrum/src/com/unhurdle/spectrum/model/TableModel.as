package com.unhurdle.spectrum.model
{
 	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.model.TableArrayListSelectionModel;
	import com.unhurdle.spectrum.TableColumn;
	import com.unhurdle.spectrum.newElement;
	import com.unhurdle.spectrum.renderers.TableItemRenderer;
	import org.apache.royale.file.beads.FileBrowser;
	import org.apache.royale.file.beads.FileLoader;
	import org.apache.royale.file.FileProxy;
	import org.apache.royale.events.ValueEvent;
	import org.apache.royale.file.beads.FileModel;
	import com.unhurdle.spectrum.Icon;
	import org.apache.royale.html.supportClasses.DataItemRenderer;
	import org.apache.royale.core.IItemRendererClassFactory;
	import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.html.beads.IListView;
	import org.apache.royale.core.IStrandWithModelView;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	import org.apache.royale.core.IStrand;
	import com.unhurdle.spectrum.renderers.ITextItemRenderer;
	
	
	
	public class TableModel extends TableArrayListSelectionModel
	{
		public function TableModel()
		{
			super();
			fileProxy = new FileProxy();
      browser = new FileBrowser();
      loader = new FileLoader();
      fileProxy.addBead(loader);  
      fileProxy.addBead(browser);
		}
		
		private var browser:FileBrowser;
    private var loader:FileLoader;
    private var fileProxy:FileProxy;
		
		private var _columns:Array;
		public function get columns():Array
		{
			return _columns;
		}
		public function set columns(value:Array):void
		{
			_columns = value;
			if(table.multiSelect){
				addMultiSelectColumn();
			}
			
		}

		private var _selectedItemProperty:Object;

    public function get selectedItemProperty():Object
		{
			return _selectedItemProperty;
		}

		public function set selectedItemProperty(value:Object):void
		{
			if(labelField == null || labelField == "") return;
        if (value == _selectedItemProperty) return;

			_selectedItemProperty = value;
			var n:int = dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				if (dataProvider.getItemAt(i) == selectedItem && dataProvider.getItemAt(i)[labelField] == value)
				{
					selectedIndex = i;
					break;
				}
			}
			dispatchEvent(new Event("selectedItemPropertyChanged"));
		}

		public function getIndexForSelectedItemProperty():Number
        {
            if (!selectedItemProperty) return -1;

			var index:int = 0;
        for(var i:int=0; i < dataProvider.length; i++) {
				for(var j:int=0; j < _columns.length; j++) {
					var column:TableColumn = _columns[j] as TableColumn;
					var test:Object = dataProvider.getItemAt(i)[column.dataField] as Object;
					
					if (dataProvider.getItemAt(i) == selectedItem && labelField == column.dataField)
					{
						return index;
					}
					index++;
				}
            }
            return -1;
		}

		private function addMultiSelectColumn():void
		{
			var multiColumn:TableColumn = new TableColumn();
			multiColumn.columnDividers = true;
			multiColumn.multiSelect = true;
			columns.unshift(multiColumn);
			
		}
			
		COMPILE::JS
	public function setDropZone():void
	{
		table.element.addEventListener('dragenter', elementDragged);
		table.element.addEventListener('dragleave', elementNotDragged); 
		table.element.addEventListener('dragover', elementDragged);
		table.element.addEventListener('drop', dropped);
		table.element.classList.add('spectrum-Table-body');
	}

	COMPILE::JS
	private function elementDragged(ev:Event):void{
		ev.preventDefault();
		table.element.classList.toggle('is-drop-target',true);
	}
	COMPILE::JS
	private function elementNotDragged(ev:Event):void{
		table.element.classList.toggle('is-drop-target',false);
	}
	COMPILE::JS
	private function dropped(ev:DragEvent):void{  
		ev.preventDefault();
		table.element.classList.toggle('is-drop-target',false);
		var fileList:FileList = ev.dataTransfer.files;
		dispatchEvent(new ValueEvent("filesAvailable",fileList));
	}

	COMPILE::JS
	private function uploadFile():void{
		fileProxy.addEventListener("modelChanged",modelChangedHandler);
		browser.browse();
	}

	COMPILE::JS
	protected function modelChangedHandler(event:Event):void
	{
			dispatchEvent(new ValueEvent("filesAvailable",[(fileProxy.model as FileModel).file]));
	}

	
	}
}