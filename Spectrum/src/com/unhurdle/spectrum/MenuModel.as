package com.unhurdle.spectrum
{
  import org.apache.royale.html.beads.models.ArraySelectionModel;
  import org.apache.royale.core.IBead;
  import org.apache.royale.events.Event;
  import org.apache.royale.core.DispatcherBead;
  import org.apache.royale.core.ISelectionModel;
  import org.apache.royale.core.IRollOverModel;
  import org.apache.royale.collections.IArrayList;
  import org.apache.royale.html.util.getLabelFromData;

  public class MenuModel extends DispatcherBead implements ISelectionModel, IRollOverModel
  {
    public function MenuModel()
    {
      
    }
		private var _untypedProvider:Object;
		// private var _listDataProvider:IArrayList;
		// private var _arrayDataProvider:Array;
		private var hasArray:Boolean;
		/**
		 *  @copy org.apache.royale.core.ISelectionModel#dataProvider
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get dataProvider():Object
		{
			return _untypedProvider;
		}

		/**
		 *  @private
		 *  @royaleignorecoercion org.apache.royale.collections.IArrayList
		 */
		public function set dataProvider(value:Object):void
		{
			if (value == _untypedProvider) return;
			hasArray = Array.isArray(value);
			_untypedProvider = value;
			if(!value || _selectedIndex >= value.length)
				_selectedIndex = -1;
            
			_selectedItem = getItemAt(_selectedIndex);
			
			dispatchEvent(new Event("dataProviderChanged"));
		}

		public function getItemAt(index:int):Object{
			if(index < 0 || !_untypedProvider){
				return null;
			}
			if(index >= _untypedProvider.length){
				return null
			}
			if(hasArray){
				return (_untypedProvider as Array)[index];
			}
			return (_untypedProvider as IArrayList).getItemAt(index);
		}
		private function getItemIndex(item:Object):int{
			if(hasArray){
				return (_untypedProvider as Array).indexOf(item);
			} else if(_untypedProvider){
				return (_untypedProvider as IArrayList).getItemIndex(item);
			}
			return -1;
		}
		private var _selectedIndex:int = -1;
		private var _rollOverIndex:int = -1;
		private var _labelField:String = null;

		/**
		 *  @copy org.apache.royale.core.ISelectionModel#labelField
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get labelField():String
		{
			return _labelField;
		}

		/**
		 *  @private
		 */
		public function set labelField(value:String):void
		{
			if (value != _labelField) {
				_labelField = value;
				dispatchEvent(new Event("labelFieldChanged"));
			}
		}

		/**
		 *  @copy org.apache.royale.core.ISelectionModel#selectedIndex
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		/**
		 *  @private
		 */
		public function set selectedIndex(value:int):void
		{
			if (value == _selectedIndex) return;

			_selectedIndex = value;
			_selectedItem = getItemAt(value);
			dispatchEvent(new Event("selectedIndexChanged"));
		}

		/**
		 *  @copy org.apache.royale.core.IRollOverModel#rollOverIndex
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get rollOverIndex():int
		{
			return _rollOverIndex;
		}

		/**
		 *  @private
		 */
		public function set rollOverIndex(value:int):void
		{
			if (value != _rollOverIndex) {
				_rollOverIndex = value;
				dispatchEvent(new Event("rollOverIndexChanged"));
			}
		}

		private var _selectedItem:Object;

		/**
		 *  @copy org.apache.royale.core.ISelectionModel#selectedItem
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get selectedItem():Object
		{
			return _selectedItem;
		}

		/**
		 *  @private
		 */
		public function set selectedItem(value:Object):void
		{
			if (value == _selectedItem) return;

			_selectedItem = value;
			_selectedIndex = getItemIndex(value);
			dispatchEvent(new Event("selectedItemChanged"));
			dispatchEvent(new Event("selectedIndexChanged"));
		}

		public function getLabelForIndex(index:int):String{
			var item:Object = getItemAt(index);
			if(item){
				return getLabelFromData(this,item);
			}
			return "";
		}

  }
}