package com.unhurdle.spectrum.data
{
  import com.unhurdle.spectrum.AssetList;
  import com.unhurdle.spectrum.SpectrumBase;
  import org.apache.royale.events.ValueEvent;

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
    COMPILE::SWF
    private function checkChild(item:Object, ev:ValueEvent):void{

    }

    COMPILE::JS
    private function checkChild(item:Object, ev:ValueEvent):void
    {
      for each (var c:Object in ev.target.dataProvider){
        if(c.isOpen){
          for(var k:int = element.parentElement.children.length-1;k>0;k--){
            if(ev.target.element != element.parentElement.children[k].children[0] ){
              this.parent.removeElement(element.parentElement.children[k].royale_wrapper);
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
    


    

   

