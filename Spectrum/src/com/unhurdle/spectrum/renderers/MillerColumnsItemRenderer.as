package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
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