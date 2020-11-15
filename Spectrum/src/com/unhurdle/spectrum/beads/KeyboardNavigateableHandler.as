package com.unhurdle.spectrum.beads
{
  import com.unhurdle.spectrum.MenuModel;
  import com.unhurdle.spectrum.interfaces.IKeyboardNavigateable;

  import org.apache.royale.core.Bead;
  import org.apache.royale.core.IBead;
  import org.apache.royale.core.ISelectionModel;
  import org.apache.royale.core.IStrand;
  import org.apache.royale.debugging.assert;
  import org.apache.royale.events.KeyboardEvent;
  import org.apache.royale.events.utils.NavigationKeys;
  import org.apache.royale.events.utils.WhitespaceKeys;
  import org.apache.royale.html.beads.IListView;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.utils.sendStrandEvent;
  import com.unhurdle.spectrum.interfaces.IKeyboardHandler;

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
		
    protected var listModel:MenuModel;
    protected var listView:IListView;
    
    override public function set strand(value:IStrand):void{
      super.strand = value;
			listModel = value.getBeadByType(ISelectionModel) as MenuModel;
			listView = value.getBeadByType(IListView) as IListView;
      host.focusParent.addEventListener(KeyboardEvent.KEY_DOWN,changeValue);
      host.focusParent.addEventListener("click",clickHandler);
    }

    protected function clickHandler(ev:Event):void{
      listModel.keyboardFocusedIndex = -1;
    }

    private function changeValue(event:KeyboardEvent):void{
      var key:String = event.key;
      switch(key)
      {
        case WhitespaceKeys.ENTER:
          listModel.selectedIndex = listModel.keyboardFocusedIndex;
          sendStrandEvent(_strand,"change");
          break;
        case NavigationKeys.RIGHT:
          if(listModel.keyboardFocusedIndex == -1){
            listModel.keyboardFocusedIndex = listModel.selectedIndex;
          }
          changeMenu();
          break;
        case NavigationKeys.LEFT:
          if(listModel.keyboardFocusedIndex == -1){
            listModel.keyboardFocusedIndex = listModel.selectedIndex;
          }
          // changeMenu();
          break;
        case NavigationKeys.DOWN:
        case NavigationKeys.UP:
          event.preventDefault();
          focusValue(key);
          break;
        default:
          if (key.length > 1) {
              return;// do nothing
          }
          updateValue(key);
          break;
      }
    }
    protected function focusNext():void{
      var startIndex:int = listModel.keyboardFocusedIndex;
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
        listModel.keyboardFocusedIndex = index;
      }
    }

    protected function focusPrevious():void{
      var startIndex:int = listModel.keyboardFocusedIndex;
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
        listModel.keyboardFocusedIndex = index;
      }
    }

    protected function canGetFocus(index:int):Boolean{
      return !(!listModel.dataProvider[index] || listModel.dataProvider[index].disabled || listModel.dataProvider[index].isDivider || listModel.dataProvider[index].isHeading);
    }

		protected var timeStamp:Number = 0;
    protected var valueToFocused:String = "";

    protected function updateValue(text:String):void{
      var current:Number = new Date().getTime();
      if(!timeStamp){
        timeStamp = current;
      }
      if(current - timeStamp  < 250){
        valueToFocused += text;
      }else{
        valueToFocused = text;
      }
      timeStamp = current;
      var txt:String = listModel.keyboardFocusedItem ? getLabelFromData(this,listModel.keyboardFocusedItem) : '';
      if(!txt || txt.toLowerCase().indexOf(valueToFocused.toLowerCase()) != 0){
        var len:int = listModel.dataProvider.length;
        for(var index:int = 0; index < len; index++){
          var t:String = listModel.dataProvider[index].text;
          if(t && t.toLowerCase().indexOf(valueToFocused.toLowerCase()) == 0){
            listModel.keyboardFocusedIndex = index;
            return;
          }
        }
      }
    }

    private function changeMenu():void{
      if(listModel.keyboardFocusedItem.subMenu){
        listModel.keyboardFocusedItem.isOpen = true;
        listModel.keyboardFocusedItem.subMenu[0].keyboardFocused = true;
      }
    }

    private var ind:Number = 0;

    protected function focusValue(type:String):void{
      var len:int = listModel.dataProvider.length;
      if(listModel.keyboardFocusedIndex == -1){
        listModel.keyboardFocusedIndex = (listModel.selectedIndex && listModel.selectedIndex != -1)? listModel.selectedIndex:0;
      }
      for(var index:int = 0; index < len; index++){
        if(!canGetFocus(index)){
          continue;
        }
        var t:String = listModel.dataProvider[index].text;
        if(t.indexOf(listModel.keyboardFocusedItem.text) == 0){
          switch(type)
          {
            case NavigationKeys.DOWN:
              focusNext();
              break;
            case NavigationKeys.UP:
              focusPrevious();
              break;
          }
          break;
        }
      }
    }
  }
}