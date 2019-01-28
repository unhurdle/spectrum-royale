package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.AssetList;
  import com.unhurdle.spectrum.data.AssetListItem;
  import com.unhurdle.spectrum.data.MillerColumnsItem;

  public class MillerColumnsItemRenderer extends DataItemRenderer
  {
    public function MillerColumnsItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-MillerColumns" + value;
    }
    override public function set data(value:Object):void{
      super.data = value;
      (element as HTMLElement).className = appendSelector("-item");
      var millerColumnsItem:MillerColumnsItem = value as MillerColumnsItem;
      // if(millerColumnsItem.assetList){
      //   (element as HTMLElement).appendChild(millerColumnsItem.assetList.element as HTMLElement);
      //   // addElement(millerColumnsItem.assetList);
      // }
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      return elem;
    }
  }
}