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
			if(value == -1){
				keyboardFocusedItem = null;
				return;
			}
      if (value == _keyboardFocusedIndex || value >= dataProvider.length) return;// || dataProvider[value].disabled
      if(dataProvider[value].disabled || dataProvider[value].isHeading || dataProvider[value].isDivider){
        keyboardFocusedIndex = keyboardFocusedIndex > value ? --value : ++value;
        return;
      }
			_keyboardFocusedIndex = value;
			_keyboardFocusedItem = (dataProvider == null) ? null : (value < dataProvider.length) ? dataProvider[value] : null;
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
			if (value == null)
				_keyboardFocusedIndex = -1;            
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
  }
}