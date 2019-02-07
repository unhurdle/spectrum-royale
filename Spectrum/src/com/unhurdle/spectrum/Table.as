package com.unhurdle.spectrum
{

	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.events.Event;
	import org.apache.royale.html.DataContainer;
	import com.unhurdle.spectrum.model.TableModel;
	import org.apache.royale.utils.ClassSelectorList;
	import org.apache.royale.utils.IClassSelectorListSupport;

	COMPILE::JS
    {
        import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
			
				
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
            return addElementToWrapper(this, 'table');
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
    }
}

