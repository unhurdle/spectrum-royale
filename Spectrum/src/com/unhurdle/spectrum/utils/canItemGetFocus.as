package com.unhurdle.spectrum.utils
{
    import com.unhurdle.spectrum.data.IMenuItem;
    import org.apache.royale.text.ime.IME;
    import org.apache.royale.core.IItemRenderer;

    public function canItemGetFocus(item:Object):Boolean
    {
      if(!item){
        return false;
      }
      if(item.disabled){
        return false;
      }
      var menuItem:IMenuItem = item as IMenuItem;
      if (!(menuItem is IMenuItem) && (menuItem is IItemRenderer))
      {
        menuItem = (menuItem as IItemRenderer).data as IMenuItem;
      }
      if(menuItem is IMenuItem){
        return !menuItem.isDivider && !menuItem.isHeading;
      }
      return true;
    }
}