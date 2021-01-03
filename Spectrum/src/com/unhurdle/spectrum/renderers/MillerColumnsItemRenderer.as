package com.unhurdle.spectrum.renderers
{
  import com.unhurdle.spectrum.data.MillerColumnsItem;

  public class MillerColumnsItemRenderer extends DataItemRenderer
  {
    public function MillerColumnsItemRenderer()
    {
      super();
      typeNames = '';
    }
    override protected function getSelector():String{
      return "spectrum-MillerColumns";
    }

    override public function set data(value:Object):void{
      super.data = value;
      toggle(appendSelector("-item"),true);
      var millerColumnsItem:MillerColumnsItem = value as MillerColumnsItem;
     
      // if(millerColumnsItem.assetList){
      //   (element as HTMLElement).appendChild(millerColumnsItem.assetList.element as HTMLElement);
      //   // addElement(millerColumnsItem.assetList);
      // }
    }
  }
}