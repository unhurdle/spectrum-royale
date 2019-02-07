package com.unhurdle.spectrum.model
{
 	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.model.TableArrayListSelectionModel;
	import com.unhurdle.spectrum.TableColumn;
	
	public class TableModel extends TableArrayListSelectionModel
	{
		public function TableModel()
		{
			super();
		}
		
		private var _columns:Array;
		public function get columns():Array
		{
			return _columns;
		}
		public function set columns(value:Array):void
		{
			_columns = value;
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
	}
}