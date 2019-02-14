package com.unhurdle.spectrum
{

	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.events.Event;
	import org.apache.royale.html.DataContainer;
	import com.unhurdle.spectrum.model.TableModel;
	import org.apache.royale.utils.ClassSelectorList;
	import org.apache.royale.utils.IClassSelectorListSupport;
	import org.apache.royale.events.CollectionEvent;
	import org.apache.royale.collections.ArrayList;

	COMPILE::JS
    {
        import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		import org.apache.royale.textLayout.property.BooleanPropertyHandler;
		import org.apache.royale.textLayout.property.BooleanPropertyHandler;
		import org.apache.royale.events.ValueEvent;
		
		
			
				
    }
	
	[DefaultProperty("columns")]

	[Event(name="initComplete", type="org.apache.royale.events.Event")]

	[Event(name="change", type="org.apache.royale.events.Event")]
	
	


	public class Table extends DataContainer implements IClassSelectorListSupport
	{
		public function Table()
		{
			super();
			
			typeNames = "spectrum-Table";
			classSelectorList = new ClassSelectorList(this);
		}

		protected var classSelectorList:ClassSelectorList;

        COMPILE::JS
        override protected function setClassName(value:String):void
        {
            classSelectorList.addNames(value);
        }

		public function get columns():Array
		{
			return TableModel(model).columns;
		}
		public function set columns(value:Array):void
		{
			TableModel(model).columns = value;
			//can i add the check- box column here ?

		}

		private var _dropZone:Boolean;

		public function get dropZone():Boolean
		{
			return _dropZone;
		}

		public function set dropZone(value:Boolean):void
		{
			_dropZone = value;
		}

		private var _fixedHeader:Boolean;
		public function get fixedHeader():Boolean
		{
			return _fixedHeader;
		}
		public function set fixedHeader(value:Boolean):void
		{
			_fixedHeader = value;

			toggleClass("fixedHeader", _fixedHeader);
		}

	private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
       if(value != !!_quiet){
        toggleClass("spectrum-Table--quiet",value);
        // toggle(valueToSelector("quiet"),value);
      }
    	_quiet = value;
    }

	private var _multiSelect:Boolean;

	public function get multiSelect():Boolean
	{
		return _multiSelect;
	}

	public function set multiSelect(value:Boolean):void
	{
		if(value == true){
			COMPILE::JS
			{
			// dispatchEvent("multiSelect");
			multiSelectHeader();
			}
			
		}
		_multiSelect = value;
	}

		// private var _tableDataHeight:Boolean;
		/**
		 *  Makes the header of the table fixed so the data rows will scroll
		 *  behind it.
		 *  
		 *  The default value is false.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		// public function get tableDataHeight():Boolean
		// {
		// 	return _tableDataHeight;
		// }
		// public function set tableDataHeight(value:Boolean):void
		// {
		// 	_tableDataHeight = value;
		// }
		
		/**
		 *  A list of data items that correspond to the rows in the table.
		 *  Each table column is associated with a property of the data items to display that property in the table cells.
		 *  
		 *  The default value is null.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		override public function get dataProvider():Object
		{
			return (model as TableModel).dataProvider;
		}
		override public function set dataProvider(value:Object):void
		{
			
			(model as TableModel).dataProvider = value;
			
		}
		
		

		[Bindable("change")]
        public function get selectedIndex():int
		{
			return (model as ISelectionModel).selectedIndex;
		}
		public function set selectedIndex(value:int):void
		{
			(model as ISelectionModel).selectedIndex = value;
		}

		[Bindable("change")]
		public function get selectedItem():Object
		{
			return (model as ISelectionModel).selectedItem;
		}
		public function set selectedItem(value:Object):void
		{
			(model as ISelectionModel).selectedItem = value;
		}

		[Bindable("change")]
		public function get selectedItemProperty():Object
		{
			return (model as TableModel).selectedItemProperty;
		}
		public function set selectedItemProperty(value:Object):void
		{
			(model as TableModel).selectedItemProperty = value;
		}

	
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
            addElementToWrapper(this, 'table');
			return element;
        }

		
     
        public function addClass(name:String):void
        {
            COMPILE::JS
            {
            classSelectorList.add(name);
            }
        }

       
        public function removeClass(name:String):void
        {
            COMPILE::JS
            {
            classSelectorList.remove(name);
            }
        }

        
        public function toggleClass(name:String, value:Boolean):void
        {
            COMPILE::JS
            {
            classSelectorList.toggle(name, value);
            }
        }

		public function containsClass(name:String):Boolean
        {
            COMPILE::JS
            {
            return classSelectorList.contains(name);
            }
            COMPILE::SWF
            {//not implemented
            return false;
            }
        }

	// [Bindable("multiSelect")]
	COMPILE::JS
	private function multiSelectHeader():void
	{ //needs an event to check the checkbox...
	//prob also needs a function to check all the boxes if checked.
		var multiSelectHeaderElem:TableHeaderCell = new TableHeaderCell();
		multiSelectHeaderElem.element.classList.add("spectrum-Table-checkboxCell");
		var label:HTMLElement = newElement('label');
		label.className = "spectrum-Checkbox";
		label.classList.add("spectrum-Table-checkbox");
		var input:HTMLElement = newElement('input');
		input.setAttribute("type","checkbox");
		input.title = "Select All";
		input.className = "spectrum-Checkbox-input";
		var span:HTMLElement = newElement('span');
		span.className = "spectrum-Checkbox-box";
		var icon:Icon = new Icon("#spectrum-css-icon-CheckmarkSmall");
		span.appendChild(icon.element); 
        icon.addedToParent();
		label.appendChild(span);
		label.appendChild(input);
		multiSelectHeaderElem.element.appendChild(label);
		// element.appendChild(multiSelectHeaderElem.element);
		
		dispatchEvent(new Event("multiSelect",multiSelectHeaderElem)); //deal with this event. //AddTableRow..
		// dispatchEvent(new Event(CollectionEvent.ITEM_ADDED,multiSelectHeaderElem));
		
		
		}

		

	
    }
}

