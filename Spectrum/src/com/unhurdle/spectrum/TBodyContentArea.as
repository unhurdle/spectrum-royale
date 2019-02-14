package com.unhurdle.spectrum
{
	import org.apache.royale.core.IItemRenderer;
  import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.ItemAddedEvent;
	import org.apache.royale.events.ItemRemovedEvent;
	import org.apache.royale.html.supportClasses.ContainerContentArea;
	import org.apache.royale.html.supportClasses.DataItemRenderer;


    COMPILE::JS
    {
      import org.apache.royale.core.WrappedHTMLElement;
			import org.apache.royale.html.util.addElementToWrapper;
			import org.apache.royale.core.WrappedHTMLElement;
			import org.apache.royale.core.WrappedHTMLElement;
			import org.apache.royale.events.ValueEvent;
			import org.apache.royale.events.ValueEvent;
			import org.apache.royale.core.CSSClassList;
		}

		import org.apache.royale.file.beads.FileModel;
		import org.apache.royale.file.beads.FileLoader;
		import org.apache.royale.file.beads.FileBrowser;
		import org.apache.royale.file.FileProxy;
		import com.unhurdle.spectrum.renderers.TableItemRenderer;




	 
	public class TBodyContentArea extends ContainerContentArea implements IItemRendererParent
	{
	
		public function TBodyContentArea()
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

	
		COMPILE::JS
		private var elem:WrappedHTMLElement;
		
		
		
		COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
		
			 	elem = addElementToWrapper(this, 'tbody');
		
	
			 	return elem;
        }

		private var itemRenderers:Array = [];

		public function addItemRenderer(renderer:IItemRenderer, dispatchAdded:Boolean):void
		{
			// this method is not used for now, so it needs to be tested to see if it's correctly implemented
			var r:DataItemRenderer = renderer as DataItemRenderer;
			r.itemRendererParent = host; // easy access from renderer to table
			// var tableCell:TableCell = new TableCell();
			// tableCell.addElement(r);

			var row:TableRow;
			if(r.rowIndex > numElements -1)
			{
				row = new TableRow();
				addElementAt(row, r.rowIndex, false);
			} 
			else
			{
				row = getElementAt(r.rowIndex) as TableRow;
			}

			row.addElement(r, dispatchAdded);
			// row.addElement(tableCell, dispatchAdded);
			
			
			itemRenderers.push(r);
			dispatchItemAdded(renderer);
		}
		
		public function addItemRendererAt(renderer:IItemRenderer, index:int):void
		{
			// COMPILE::JS{
			// if((r.itemRendererParent as Table).dropZone == true){
			// element = newElement('div') as WrappedHTMLElement;
			// element.classList.add('spectrum-Table-body');
			// element.classList.add('is-drop-target');
			// element.style.height = 120;
			// element.setAttribute("role","rowgroup");
			// }
			// }
	
			var r:DataItemRenderer = renderer as DataItemRenderer;
			
			r.itemRendererParent = host; // easy access from renderer to table
			COMPILE::JS{
			if((r.itemRendererParent as Table).dropZone == true){
			// element.classList.add('is-drop-target');
			element.addEventListener('dragenter', elementDragged);
    	element.addEventListener('dragleave', elementNotDragged); 
    	element.addEventListener('dragover', elementDragged);
    	element.addEventListener('drop', dropped);
			element.classList.add('spectrum-Table-body');
			}
			else{
				element.className = "spectrum-Table-body";
			}
			}
			// var tableCell:TableCell = new TableCell();
			// tableCell.addElement(r);
			
			var row:TableRow;
			if(r.rowIndex > numElements - 1)
			{
				row = new TableRow();
				addElementAt(row, r.rowIndex, false);
			} 
			else
			{
				row = getElementAt(r.rowIndex) as TableRow;
			}

			row.addElementAt(r, r.columnIndex, true);
			// row.addElementAt(tableCell, r.columnIndex, true);
			var t:Table = r.itemRendererParent as Table;

			for (var i:Number = 0;i<t.columns.length;i++){
				if(t.columns[i].columnDividers == true){
					if(r.dataField == t.columns[i].dataField){
						COMPILE::JS
						{
								r.element.classList.add("spectrum-Table-cell--divider");
						}
					
					}
				}
			}

	
			itemRenderers.push(r);
			dispatchItemAdded(r);
		}
		
		public function dispatchItemAdded(renderer:IItemRenderer):void
		{
			var newEvent:ItemAddedEvent = new ItemAddedEvent("itemAdded");
			newEvent.item = renderer;
			
			(host as IEventDispatcher).dispatchEvent(newEvent);
		}
		
		public function removeItemRenderer(renderer:IItemRenderer):void
		{
			itemRenderers.splice(itemRenderers.indexOf(renderer), 1);
			var newEvent:ItemRemovedEvent = new ItemRemovedEvent("itemRemoved");
			newEvent.item = renderer;
			(host as IEventDispatcher).dispatchEvent(newEvent);
		}

		private var processedRow:TableRow;
		
		public function removeAllItemRenderers():void
		{ //fix bc no tableCell being used
			while (numElements > 0) {
				processedRow = getElementAt(0) as TableRow;
				while (processedRow.numElements > 0) {
					var cell:TableItemRenderer = processedRow.getElementAt(0) as TableItemRenderer;
					// var cell:TableCell = processedRow.getElementAt(0) as TableCell;
					// var ir:IItemRenderer = cell.getElementAt(0) as IItemRenderer; //pb
					removeItemRenderer(cell);
					// cell.removeElement(ir);  //pb
					processedRow.removeElement(cell);
				}
				removeElement(processedRow);
			}
		}
		
		public function getItemRendererAt(index:int):IItemRenderer
		{
			if (index < 0 || index >= itemRenderers.length) return null;
			return itemRenderers[index] as IItemRenderer;
		}

		public function getItemRendererForIndex(index:int):IItemRenderer
		{
			if (index < 0 || index >= itemRenderers.length) return null;
			return itemRenderers[index] as IItemRenderer;
		}

		public function updateAllItemRenderers():void
		{
			var n:Number = numElements;
			for (var i:Number = 0; i < n; i++)
			{
				var renderer:DataItemRenderer = getItemRendererAt(i) as DataItemRenderer;
				if (renderer) {
					renderer.setWidth(this.width,true);
					renderer.adjustSize();
				}
			}
		}
	
		COMPILE::JS
		private function elementDragged(ev:Event):void{
      ev.preventDefault();
      // toggle("is-dragged",true);
			element.classList.toggle('is-drop-target',true);
    }
		COMPILE::JS
    private function elementNotDragged(ev:Event):void{
      element.classList.toggle('is-drop-target',false);
    }
		COMPILE::JS
    private function dropped(ev:DragEvent):void{  
      ev.preventDefault();
      element.classList.toggle('is-drop-target',false);
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
	
		public function get numItemRenderers():int{
			return numElements;
		}
		COMPILE::JS
		protected var classList:CSSClassList;
		COMPILE::JS
    protected function toggle(classNameVal:String,add:Boolean):void
    {
      COMPILE::JS
      {
        add ? classList.add(classNameVal) : classList.remove(classNameVal);
        setClassName(computeFinalClassNames());
      }
    }
    }
	}
