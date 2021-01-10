package com.unhurdle.spectrum.beads
{
  import com.unhurdle.spectrum.ListModel;
  import com.unhurdle.spectrum.data.IMenuItem;
  import com.unhurdle.spectrum.interfaces.IKeyboardHandler;
  import com.unhurdle.spectrum.interfaces.IKeyboardNavigateable;
  import com.unhurdle.spectrum.renderers.DataItemRenderer;

  import org.apache.royale.core.Bead;
  import org.apache.royale.core.IBead;
  import org.apache.royale.core.IParent;
  import org.apache.royale.core.ISelectionModel;
  import org.apache.royale.core.IStrand;
  import org.apache.royale.debugging.assert;
  import org.apache.royale.events.Event;
  import org.apache.royale.events.KeyboardEvent;
  import org.apache.royale.events.utils.NavigationKeys;
  import org.apache.royale.events.utils.WhitespaceKeys;
  import org.apache.royale.html.beads.DataContainerView;
  import org.apache.royale.html.beads.IListView;
  import org.apache.royale.utils.sendStrandEvent;

  public class KeyboardNavigateableHandler extends Bead implements IBead, IKeyboardHandler
  {
    public function KeyboardNavigateableHandler()
    {
      super();
    }
    protected function get host():IKeyboardNavigateable{
      assert(_strand is IKeyboardNavigateable,"The strand must be an IKeyboardNavigateable!");
      return _strand as IKeyboardNavigateable;
    }
		
    protected var listModel:ListModel;
    protected var listView:IListView;
    
    override public function set strand(value:IStrand):void{
      super.strand = value;
			listModel = value.getBeadByType(ISelectionModel) as ListModel;
			listView = value.getBeadByType(IListView) as IListView;
      host.focusParent.addEventListener(KeyboardEvent.KEY_DOWN,changeValue);
      host.focusParent.addEventListener("click",clickHandler);
      listenOnStrand("itemsCreated",handleItemsCreated);
      listenOnStrand("focusIn",focusItem);
      listenOnStrand("change",handleChange);
			// listenOnStrand("itemAdded", handleItemAdded);
			// listenOnStrand("itemRemoved", handleItemRemoved);

    }
    /**
     * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
     */
		// protected function handleItemAdded(event:ItemAddedEvent):void
		// {
		// 	(event.item as IEventDispatcher).addEventListener("focusIn", focusInHandler);
		// }
		
        /**
         * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
         */
		// protected function handleItemRemoved(event:ItemRemovedEvent):void
		// {
		// 	(event.item as IEventDispatcher).removeEventListener("focusIn", focusInHandler);
		// }

    protected function getRendererIndex(renderer:DataItemRenderer):int{
      // ugly, but there's no interface for this at the moment
      if(!renderer){
        return -1;
      }
      return ((listView as DataContainerView).contentView as IParent).getElementIndex(renderer);
    }
    private function getRendererForIndex(index:int):DataItemRenderer{
      return listView.dataGroup.getItemRendererForIndex(index) as DataItemRenderer;
    }
    protected var focusableItemRenderer:DataItemRenderer;
    protected function handleItemsCreated(event:Event):void{
      if(focusableItemRenderer){
        focusableItemRenderer.keyboardFocused = false;
        focusableItemRenderer.tabFocusable = false;
      }
       var ir:DataItemRenderer = focusableItemRenderer;
       if(!ir){
         ir = findFirstFocusable();
       }
       if(ir){
         ir.tabFocusable = true;
         focusableItemRenderer = ir;
       } else {
         focusableItemRenderer = null;
       }
    }
    protected function clickHandler(ev:Event):void{
      //TODO what was this for?
      // listModel.keyboardFocusedIndex = -1;
    }

    protected function changeValue(event:KeyboardEvent):void{
      var key:String = event.key;
      var index:int;
      switch(key)
      {
        case WhitespaceKeys.ENTER:// enter should always trigger "change" even if it's not changing to ensure that popups are closed
          listModel.selectedIndex = getRendererIndex(focusableItemRenderer);
          sendStrandEvent(_strand,"change");
          break;
        case NavigationKeys.RIGHT:
        //TODO what does this do?
          // if(listModel.keyboardFocusedIndex == -1){
          //   listModel.keyboardFocusedIndex = listModel.selectedIndex;
          // }
          // changeMenu();
          break;
        case NavigationKeys.LEFT:
        //TODO what does this do?
          // if(listModel.keyboardFocusedIndex == -1){
          //   listModel.keyboardFocusedIndex = listModel.selectedIndex;
          // }
          // changeMenu();
          break;
        case NavigationKeys.DOWN:
          event.preventDefault();
          focusNext();
          break;
        case NavigationKeys.UP:
          event.preventDefault();
          focusPrevious();
          break;
        default:
          if (key.length > 1) {
              return;// do nothing
          }
          updateValue(key);
          break;
      }
    }
    protected function handleChange(event:Event):void{
      var ir:DataItemRenderer = getRendererForIndex(listModel.selectedIndex);
      if(ir != focusableItemRenderer){
        if(focusableItemRenderer){
          focusableItemRenderer.keyboardFocused = false;
          focusableItemRenderer.tabFocusable = false;
        }
        if(ir){
          ir.tabFocusable = true;
        }
        focusableItemRenderer = ir;
      } 
      focusItem();
    }
    protected function focusItem():void{
      if(focusableItemRenderer){
        focusableItemRenderer.pauseFocusEvents = true;
        focusableItemRenderer.focus();
        focusableItemRenderer.pauseFocusEvents = false;
			}else if(listModel.selectedIndex >= 0){
        focusableItemRenderer = getRendererForIndex(listModel.selectedIndex);
        if(focusableItemRenderer){
          focusableItemRenderer.tabFocusable = true;
          focusableItemRenderer.pauseFocusEvents = true;
          focusableItemRenderer.focus();
          focusableItemRenderer.pauseFocusEvents = false;
        }
      } else {

      }
    }
    protected function focusNext():void{
      var startIndex:int = getRendererIndex(focusableItemRenderer);
      if(startIndex > -1){// we have a valid renderer
        if(!focusableItemRenderer.keyboardFocused){
          startIndex--;
        }
      } else if(listModel.selectedIndex > -1){
        startIndex = listModel.selectedIndex-1;
      }
      var index:int = startIndex + 1;
      while(index < listView.dataGroup.numItemRenderers && !canGetFocus(index)){
        index++;
      }
      if(index >= listView.dataGroup.numItemRenderers){
        index = 0;
        while(index < startIndex && !canGetFocus(index)){
          index++;
        }
      }
      if(index != startIndex){
        changeFocus(index);
      }
    }

    protected function focusPrevious():void{
      var startIndex:int = getRendererIndex(focusableItemRenderer);
      if(startIndex > -1){// we have a valid renderer
        if(!focusableItemRenderer.keyboardFocused){
          startIndex--;
        }
      } else if(listModel.selectedIndex > -1){
        startIndex = listModel.selectedIndex+1;
      }
      var index:int = startIndex - 1;
      while(index > -1 && !canGetFocus(index)){
        index--;
      }
      if(index < 0){
        index = listView.dataGroup.numItemRenderers - 1;
        while(index > startIndex && !canGetFocus(index)){
          index--;
        }
      }
      if(index != startIndex){
        changeFocus(index);
      }
    }
    protected function changeFocus(index:int):void{
      var ir:DataItemRenderer = getRendererForIndex(index);
      if(ir && ir == focusableItemRenderer){
        focusableItemRenderer.keyboardFocused = true;
        return;// done
      }
    	if(focusableItemRenderer){
				focusableItemRenderer.keyboardFocused = false;
        focusableItemRenderer.tabFocusable = false;
      }
			if(ir){
				ir.keyboardFocused = true;
        focusableItemRenderer = ir;
			} else {
        focusableItemRenderer = findFirstFocusable();
        if(focusableItemRenderer){
          focusableItemRenderer.tabFocusable = true;
        }
      }
		}
    private function findFirstFocusable():DataItemRenderer{
      var idx:int = 0;
      while(idx < listView.dataGroup.numItemRenderers){
        if(canGetFocus(idx)){
          return getRendererForIndex(idx);
        }
        idx++;
      }
      return null;
    }

    protected function canGetFocus(index:int):Boolean{
      var item:Object = getRendererForIndex(index).data;
      if(!item){
        return false;
      }
      if(item.disabled){
        return false;
      }
      if(item is IMenuItem){
        return !(item as IMenuItem).isDivider && !(item as IMenuItem).isHeading;
      }
      return true;
    }

		protected var timeStamp:Number = 0;
    protected var valueToFocus:String = "";

    protected function updateValue(text:String):void{
      var current:Number = new Date().getTime();
      if(!timeStamp){
        timeStamp = current;
      }
      if(current - timeStamp  < 250){
        valueToFocus += text;
      }else{
        valueToFocus = text;
      }
      timeStamp = current;
      var txt:String = listModel.getLabelForIndex(getRendererIndex(focusableItemRenderer));
      if(!txt || txt.toLowerCase().indexOf(valueToFocus.toLowerCase()) != 0){
        var len:int = listModel.dataProvider.length;
        for(var index:int = 0; index < len; index++){
          var t:String = listModel.getLabelForIndex(index);
          if(t && t.toLowerCase().indexOf(valueToFocus.toLowerCase()) == 0){
            changeFocus(index);
            return;
          }
        }
      }
    }

    private function changeMenu():void{
      if(!focusableItemRenderer){
        return;
      }
      var data:Object = focusableItemRenderer.data;
      if(!(data is IMenuItem)){
        return;
      }
      var menu:IMenuItem = data as IMenuItem;
      if(menu.subMenu){
        menu.isOpen = true;
        menu.subMenu[0].keyboardFocused = true;
      }
    }

    private var ind:Number = 0;

    // protected function focusValue(type:String):void{
    //   var len:int = listModel.dataProvider.length;

    //   if(listModel.keyboardFocusedIndex == -1){
    //     listModel.keyboardFocusedIndex = (listModel.selectedIndex && listModel.selectedIndex != -1)? listModel.selectedIndex:0;
    //   }
    //   for(var index:int = 0; index < len; index++){
    //     if(!canGetFocus(index)){
    //       continue;
    //     }
    //     var t:String = listModel.dataProvider[index].text;
    //     if(t.indexOf(listModel.keyboardFocusedItem.text) == 0){
    //       switch(type)
    //       {
    //         case NavigationKeys.DOWN:
    //           focusNext();
    //           break;
    //         case NavigationKeys.UP:
    //           focusPrevious();
    //           break;
    //       }
    //       break;
    //     }
    //   }
    // }

  }
}