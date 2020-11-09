package com.unhurdle.spectrum
{
  import org.apache.royale.html.beads.models.ArraySelectionModel;
  import org.apache.royale.core.IBead;
  import org.apache.royale.events.Event;

  public class MenuModel extends ArraySelectionModel implements IBead
  {
    public function MenuModel()
    {
      
    }

		override public function set dataProvider(value:Object):void
		{
      super.dataProvider = value;
			if(!dataProvider || _focusedIndex >= dataProvider.length)
				_focusedIndex = -1;			
			_focusedItem = _focusedIndex == -1 ? null : dataProvider[_focusedIndex];
			if(!dataProvider || _keyboardFocusedIndex >= dataProvider.length)
				_keyboardFocusedIndex = -1;			
			_keyboardFocusedItem = _keyboardFocusedIndex == -1 ? null : dataProvider[_keyboardFocusedIndex];
		}
    
		private var _keyboardFocusedIndex:int = -1;

		public function get keyboardFocusedIndex():int
		{
			return _keyboardFocusedIndex;
		}

		public function set keyboardFocusedIndex(value:int):void
		{
      if (value == _keyboardFocusedIndex || value == -1 || value >= dataProvider.length) return;// || dataProvider[value].disabled
      if(dataProvider[value].disabled || dataProvider[value].isHeading || dataProvider[value].isDivider){
        keyboardFocusedIndex = keyboardFocusedIndex > value ? --value : ++value;
        return;
      }
			_keyboardFocusedIndex = value;
			_keyboardFocusedItem = (value == -1 || dataProvider == null) ? null : (value < dataProvider.length) ? dataProvider[value] : null;
			dispatchEvent(new Event("keyboardFocusedIndexChanged"));			
		}
		private var _keyboardFocusedItem:Object;

		public function get keyboardFocusedItem():Object
		{
			return _keyboardFocusedItem;
		}

		public function set keyboardFocusedItem(value:Object):void
		{
            if (value == _keyboardFocusedItem) return;
            
			_keyboardFocusedItem = value;	
			var n:int = dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				if (dataProvider[i] == value)
				{
					_keyboardFocusedIndex = i;
					break;
				}
			}
			dispatchEvent(new Event("keyboardFocusedItemChanged"));			
			dispatchEvent(new Event("keyboardFocusedIndexChanged"));
		}

		private var _focusedIndex:int = -1;

		public function get focusedIndex():int
		{
			return _focusedIndex;
		}

		public function set focusedIndex(value:int):void
		{
      if (value == _focusedIndex || value == -1 || value >= dataProvider.length) return; // || dataProvider[value].disabled
      if(dataProvider[value].disabled || dataProvider[value].isHeading || dataProvider[value].isDivider){
        focusedIndex = focusedIndex > value ? --value : ++value;
        return;
      }
			_focusedIndex = value;
			_focusedItem = (value == -1 || dataProvider == null) ? null : (value < dataProvider.length) ? dataProvider[value] : null;
			dispatchEvent(new Event("focusedIndexChanged"));			
		}
		private var _focusedItem:Object;

		public function get focusedItem():Object
		{
			return _focusedItem;
		}

		public function set focusedItem(value:Object):void
		{
            if (value == _focusedItem) return;
            
			_focusedItem = value;	
			var n:int = dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				if (dataProvider[i] == value)
				{
					_focusedIndex = i;
					break;
				}
			}
			dispatchEvent(new Event("focusedItemChanged"));			
			dispatchEvent(new Event("focusedIndexChanged"));
		}
  }
}