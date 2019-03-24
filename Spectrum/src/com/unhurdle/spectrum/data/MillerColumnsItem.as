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
  import org.apache.royale.core.IChild;

  public class MillerColumnsItem extends SpectrumBase
  {
    public function MillerColumnsItem(obj:Object)
    {
      super();
      this.object = obj;
      assetList = new AssetList();
      assetList.dataProvider = obj;
      assetList.addEventListener("itemClicked",itemClicked);
      addElement(assetList);
      typeNames = 'spectrum-MillerColumns-item';
    }
    private var assetList:AssetList;
    private var object:Object;
    COMPILE::JS
    private var elem:WrappedHTMLElement;
    COMPILE::SWF
    private var elem:Object;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      elem = addElementToWrapper(this,'div');
      return elem;
    }
 
    private function itemClicked(ev:ValueEvent):void
    {
      if(ev.value.isOpen){
        return;
      }
  
      for each(var item:Object in assetList.dataProvider)
      {
        if(item.selected){
          checkChild(item,ev);
        return;
        }
      }
      if(ev.value.children){
        ev.value.isOpen = true;
        var newElem:MillerColumnsItem = new MillerColumnsItem(ev.value.children);
        this.parent.addElement(newElem);
      }
      ev.value.selected = true;
    }

    private function checkChild(item:Object, ev:ValueEvent):void
    {
      for each (var c:Object in ev.target.dataProvider){
        if(c.isOpen){
          for(var k:int = elem.parentElement.children.length-1;k>0;k--){
            if(ev.target.element != elem.parentElement.children[k].children[0] ){
              this.parent.removeElement(elem.parentElement.children[k].royale_wrapper);
            }
          }
          toFalse(c);
        }
        if(ev.value == item){
          if(item.isOpen == false){
            reOpen(item);
            break;
          }
        }
      }
    }
    
    private function reOpen(item:Object):void{ 
      item.isOpen = true;
      var newElem:MillerColumnsItem = new MillerColumnsItem(item.children);
      this.parent.addElement(newElem);
      item.selected = true;
    }

    private function toFalse(c:Object):void
    {
      if(c.isOpen){
        c.isOpen = false;
      }
      if(c.children){
        for each (var child:Object in c.children){
          toFalse(child);
        }
      }
    }

    
  }
}
    


    

   

