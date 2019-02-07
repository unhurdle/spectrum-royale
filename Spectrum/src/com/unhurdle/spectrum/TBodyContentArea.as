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
    }


	 
	public class TBodyContentArea extends ContainerContentArea implements IItemRendererParent
	{
	
		public function TBodyContentArea()
		{
			super();

			typeNames = "spectrum-Table-body";
		}
		
		COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
			return addElementToWrapper(this, 'tbody');
        }

		private var itemRenderers:Array = [];

		public function addItemRenderer(renderer:IItemRenderer, dispatchAdded:Boolean):void
		{
			// this method is not used for now, so it needs to be tested to see if it's correctly implemented
			var r:DataItemRenderer = renderer as DataItemRenderer;
			r.itemRendererParent = host; // easy access from renderer to table
			var tableCell:TableCell = new TableCell();
			tableCell.addElement(r);

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

			row.addElement(tableCell, dispatchAdded);
			
			itemRenderers.push(r);
			dispatchItemAdded(renderer);
		}
		
		public function addItemRendererAt(renderer:IItemRenderer, index:int):void
		{
			
			var r:DataItemRenderer = renderer as DataItemRenderer;
			
			r.itemRendererParent = host; // easy access from renderer to table
			
			var tableCell:TableCell = new TableCell();
			tableCell.addElement(r);

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

			row.addElementAt(tableCell, r.columnIndex, true);
			
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
					var cell:TableCell = processedRow.getElementAt(0) as TableCell;
					var ir:IItemRenderer = cell.getElementAt(0) as IItemRenderer;
					removeItemRenderer(ir);
					cell.removeElement(ir);
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
    }
}