package com.unhurdle.spectrum.data
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.AssetList;
  import com.unhurdle.spectrum.SpectrumBase;
  import org.apache.royale.events.ValueEvent;

  public class MillerColumnsItem extends SpectrumBase
  {
    public function MillerColumnsItem(obj:Object)
    {
      super();
      this.object = obj;
      // for each(var c:Object in obj)
      // {
      //   var assetItem:AssetListItem = new AssetListItem(c.text);
      //   if(obj.selectable)
      //     assetItem = obj.selectable;
      //   if(obj.iconType)
      //     assetItem = obj.iconType;
      //   if(obj.src)
      //     assetItem = obj.src;
      //   if(obj.isBranch)
      //     assetItem = obj.isBranch;
      //   c = assetList;
      // }
      assetList = new AssetList();
      assetList.dataProvider = obj;
      assetList.addEventListener("itemClicked",itemClicked);
      addElement(assetList);
      typeNames = 'spectrum-MillerColumns-item';
    }
    private var assetList:AssetList;
    private var object:Object;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      return elem;
    }
    private function itemClicked(ev:ValueEvent):void
    {
      // ev.value.selected = !ev.value.selected;
      for each(var item:Object in assetList.dataProvider)
      {
        if(item.isOpen){
          item.isOpen = false;
        }
      }
      if(ev.value.children ){
        ev.value.isOepn = true;
        this.parent.addElement(new MillerColumnsItem(ev.value.children));
      }
    }
  }
}