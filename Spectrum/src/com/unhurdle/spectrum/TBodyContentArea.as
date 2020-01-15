package com.unhurdle.spectrum
{
	import org.apache.royale.core.IItemRenderer;
  import org.apache.royale.core.IItemRendererParent;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.ItemAddedEvent;
	import org.apache.royale.events.ItemRemovedEvent;
	import org.apache.royale.html.supportClasses.ContainerContentArea;
	import org.apache.royale.html.supportClasses.DataItemRenderer;
	import com.unhurdle.spectrum.renderers.TableItemRenderer;
	import org.apache.royale.core.IChild;
	import com.unhurdle.spectrum.renderers.TableItemRendererFactoryForCollectionView;

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

	[Event(name="filesAvailable", type="org.apache.royale.events.ValueEvent")]
	 
	public class TBodyContentArea extends ContainerContentArea implements IItemRendererParent
	{
	
		public function TBodyContentArea()
		{
			super();
		 
		}
		
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
		// 	// this method is not used for now, so it needs to be tested to see if it's correctly implemented
		// 	var r:DataItemRenderer = renderer as DataItemRenderer;
		// 	r.itemRendererParent = host; // easy access from renderer to table
		// 	// var tableCell:TableCell = new TableCell();
		// 	// tableCell.addElement(r);

		// 	var row:TableRow;
		// 	if(r.rowIndex > numElements -1)
		// 	{
		// 		row = new TableRow();
		// 		addElementAt(row, r.rowIndex, false);
		// 	} 
		// 	else
		// 	{
		// 		row = getElementAt(r.rowIndex) as TableRow;
		// 	}
		// 	row.addElement(r, dispatchAdded);
		// 	// row.addElement(tableCell, dispatchAdded);
		// 	itemRenderers.push(r);
		// 	dispatchItemAdded(renderer);
		}
		
		public function addItemRendererAt(renderer:IItemRenderer, index:int):void
		{
			var r:DataItemRenderer = renderer as DataItemRenderer;
			r.itemRendererParent = host; // easy access from renderer to table
			COMPILE::JS{
				element.className = "spectrum-Table-body";
			}
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
		{ 
			while (numElements > 0) {
				processedRow = getElementAt(0) as TableRow;
				while (processedRow.numElements > 0) {
					var cell:TableItemRenderer = processedRow.getElementAt(0) as TableItemRenderer;
					removeItemRenderer(cell);
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
	
		
		public function get numItemRenderers():int{
			return numElements;
		}
		COMPILE::JS
		protected var classList:CSSClassList;
		COMPILE::JS
    public function toggle(classNameVal:String,add:Boolean):void
    {
      COMPILE::JS
      {
        add ? classList.add(classNameVal) : classList.remove(classNameVal);
        setClassName(computeFinalClassNames());
      }
    }

		
		COMPILE::JS
		private function checkBoxCell():DataItemRenderer
		{
			var ir:TableItemRenderer = new TableItemRenderer();
			ir.itemRendererParent = host;
			ir.element.classList.add("spectrum-Table-checkboxCell");
			var label:HTMLElement = newElement('label');
			label.className = "spectrum-Checkbox";
			label.classList.add("spectrum-Table-checkbox");
			var input:HTMLElement = newElement('input');
			input.setAttribute("type","checkbox");
			input.title = "Select All";
			input.className = "spectrum-Checkbox-input";
			var span:HTMLElement = newElement('span');
			span.className = "spectrum-Checkbox-box";
			var type:String = "CheckmarkSmall";
			var icon:Icon = new Icon(Icon.getCSSTypeSelector(type));
			icon.type = type;
			icon.className = "spectrum-Checkbox-checkmark";
			span.appendChild(icon.element); 
			icon.addedToParent();
			label.appendChild(input);
			label.appendChild(span);
			ir.element.appendChild(label);
			(parent as Table).model.columns[0].itemRenderer = ir as DataItemRenderer;
			return ir;
			}
		}
	}
