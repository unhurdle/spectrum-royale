package com.unhurdle.spectrum.beads
{


  import com.unhurdle.spectrum.interfaces.IKeyboardHandler;
  import com.unhurdle.spectrum.renderers.TreeItemRenderer;

  import org.apache.royale.core.IStrand;
  import org.apache.royale.events.ItemClickedEvent;
  import org.apache.royale.events.KeyboardEvent;
  import org.apache.royale.events.utils.NavigationKeys;

  public class KeyboardNavigateableForTreeHandler extends KeyboardNavigateableHandler implements IKeyboardHandler
  {
    public function KeyboardNavigateableForTreeHandler()
    {
      super();
    }
    
    override public function set strand(value:IStrand):void{
      super.strand = value;
      host.focusParent.removeEventListener("click",clickHandler);
    }
    override protected function changeValue(event:KeyboardEvent):void{
      super.changeValue(event);
      var key:String = event.key;
      var treeRenderer:TreeItemRenderer = focusableItemRenderer as TreeItemRenderer;
      switch(key)
      {
        case NavigationKeys.RIGHT:
          if(focusableItemRenderer){
            if(!treeRenderer.isOpen){
              focusableItemRenderer.addEventListener("expanded",function ():void
              {
                focusableItemRenderer.keyboardFocused = true;
              })
              treeRenderer.isOpen = true;
              var expandEvent:ItemClickedEvent = new ItemClickedEvent("itemExpanded");
              expandEvent.data = focusableItemRenderer.data;
              expandEvent.index = getRendererIndex(focusableItemRenderer);;
              //wait until all the intem renderers are updated to modify the list 
              setTimeout(function():void{
                focusableItemRenderer.dispatchEvent(expandEvent);
              })
            }
          }
          break;
        case NavigationKeys.LEFT:
          if(focusableItemRenderer ){
            if(treeRenderer.isOpen){
              treeRenderer.isOpen = false;
              var expandEvent1:ItemClickedEvent = new ItemClickedEvent("itemExpanded");
              expandEvent1.data = focusableItemRenderer.data;
              expandEvent1.index = getRendererIndex(focusableItemRenderer);;
              //wait until all the intem renderers are updated to modify the list 
              setTimeout(function():void{
                focusableItemRenderer.dispatchEvent(expandEvent1);
              })
            }
          }
          break;
      }
    }

  }
}