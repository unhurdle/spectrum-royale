package com.unhurdle.spectrum.model
{
  import org.apache.royale.collections.IArrayList;
	import org.apache.royale.core.IRollOverModel;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;
	import com.unhurdle.spectrum.Table;
	
  public class TableArrayListSelectionModel extends EventDispatcher implements ISelectionModel,IRollOverModel
  {

    public function TableArrayListSelectionModel()
    {
      
    }
		protected var table:Table;
    private var _strand:IStrand;

     
		public function set strand(value:IStrand):void
		{
			_strand = value;
			table = value as Table;

		}

		private var _dataProvider:IArrayList;

		[Bindable("dataProviderChanged")]
       
		public function get dataProvider():Object
		{
			return _dataProvider;
		}

       
		public function set dataProvider(value:Object):void
		{
            if (value == _dataProvider) return;

       _dataProvider = value as IArrayList;
			if(!_dataProvider || _selectedIndex >= _dataProvider.length)
				_selectedIndex = -1;
            
			_selectedItem = _selectedIndex == -1 ? null : _dataProvider.getItemAt(_selectedIndex);
			
			dispatchEvent(new Event("dataProviderChanged"));
		}

		private var _selectedIndex:int = -1;
		private var _rollOverIndex:int = -1;
		private var _labelField:String = null;

      
		public function get labelField():String
		{
			return _labelField;
		}

		public function set labelField(value:String):void
		{
			if (value != _labelField) {
				_labelField = value;
				dispatchEvent(new Event("labelFieldChanged"));
			}
		}

   
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

    
		public function set selectedIndex(value:int):void
		{
      if (value == _selectedIndex) return;

			_selectedIndex = value;
			_selectedItem = (value == -1 || _dataProvider == null) ? null : (value < _dataProvider.length) ? _dataProvider.getItemAt(value) : null;
			dispatchEvent(new Event("selectedIndexChanged"));
		}

		public function get rollOverIndex():int
		{
			return _rollOverIndex;
		}

		public function set rollOverIndex(value:int):void
		{
			if (value != _rollOverIndex) {
				_rollOverIndex = value;
				dispatchEvent(new Event("rollOverIndexChanged"));
			}
		}

		private var _selectedItem:Object;

		public function get selectedItem():Object
		{
			return _selectedItem;
		}

		public function set selectedItem(value:Object):void
		{
            if (value == _selectedItem) return;

			_selectedItem = value;
			var n:int = _dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				if (_dataProvider.getItemAt(i) == value)
				{
					_selectedIndex = i;
					break;
				}
			}
			dispatchEvent(new Event("selectedItemChanged"));
			dispatchEvent(new Event("selectedIndexChanged"));
		}

		private var _selectedString:String;

		public function get selectedString():String
		{
			return String(_selectedItem);
		}
    public function set selectedString(value:String):void
		{
			_selectedString = value;
			var n:int = _dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				if ((_dataProvider.getItemAt(i) as String) == value)
				{
					_selectedIndex = i;
					break;
				}
			}
			dispatchEvent(new Event("selectedItemChanged"));
			dispatchEvent(new Event("selectedIndexChanged"));
		}
  }
}