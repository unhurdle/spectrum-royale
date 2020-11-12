package com.unhurdle.spectrum
{
  public class TreeModel extends MenuModel
  {
    public function TreeModel()
    {
      
    }

		override public function set dataProvider(value:Object):void
		{
      super.dataProvider = value;
			if(!dataProvider || super.keyboardFocusedIndex >= dataProvider.length)
				super.keyboardFocusedIndex = -1;
			super.keyboardFocusedItem = super.keyboardFocusedIndex == -1 ? null : dataProvider.getItemAt(super.keyboardFocusedIndex);
		}

		override public function set keyboardFocusedIndex(value:int):void
		{
			if(value == super.keyboardFocusedIndex){
				return;
			}
			if(value == -1){
				if(!!super.keyboardFocusedItem){
					super.keyboardFocusedItem = null;
				}
				super.keyboardFocusedIndex = -1;
				return;
			}
			super.keyboardFocusedIndex = value;
			super.keyboardFocusedItem = dataProvider.getItemAt(value);
		}

		override public function set keyboardFocusedItem(value:Object):void
		{
			if (value == super.keyboardFocusedItem) return;
			if (value == null && super.keyboardFocusedIndex != -1){
				super.keyboardFocusedIndex = -1;
				super.keyboardFocusedItem = null;
				return;
			}
			super.keyboardFocusedItem = value;
			var n:int = dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				if (dataProvider.getItemAt(i) == value)
				{
					super.keyboardFocusedIndex = i;
					break;
				}
			}
		}
  }
}