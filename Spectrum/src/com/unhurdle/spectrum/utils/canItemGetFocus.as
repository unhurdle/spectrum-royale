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
      var menuItem:IMenuItem = item as IMenuItem;
      if (!(item is IMenuItem) && (item is IItemRenderer))
      {
        menuItem = (item as IItemRenderer).data as IMenuItem;
      }
      if(menuItem is IMenuItem){
        return !menuItem.isDivider && !menuItem.isHeading;
      }
      return true;
    }
}