package com.unhurdle.spectrum.utils
{
		import com.unhurdle.spectrum.data.IMenuItem;
		import org.apache.royale.core.IItemRenderer;
		/**
		 * @royaleignorecoercion com.unhurdle.spectrum.data.IMenuItem
		 */
		public function canItemGetFocus(item:Object):Boolean
		{
			if(!item){
				return false;
			}
			// TODO: Make this type-safe
			if(item.disabled){
				return false;
			}
			if(item is IMenuItem){
				var menuItem:IMenuItem = item as IMenuItem;
				return !menuItem.isDivider && !menuItem.isHeading;
			}
			if (item is IItemRenderer){
				menuItem = (item as IItemRenderer).data as IMenuItem;
			}
			return true;
		}
}