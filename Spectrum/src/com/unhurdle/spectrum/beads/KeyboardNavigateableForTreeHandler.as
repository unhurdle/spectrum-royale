package com.unhurdle.spectrum.beads
{


  import com.unhurdle.spectrum.interfaces.IKeyboardHandler;

  import org.apache.royale.events.utils.NavigationKeys;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.core.IStrand;

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

    override protected function canGetFocus(index:int):Boolean{
      return !(!listModel.dataProvider.getItemAt(index) || listModel.dataProvider.getItemAt(index).disabled || listModel.dataProvider.getItemAt(index).isDivider || listModel.dataProvider.getItemAt(index).isHeading);
    }

    override protected function updateValue(text:String):void{
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
          var t:String = listModel.dataProvider.getItemAt(index).label;
          if(t && t.toLowerCase().indexOf(valueToFocused.toLowerCase()) == 0){
            listModel.keyboardFocusedIndex = index;
            return;
          }
        }
      }
    }

    override protected function focusValue(type:String):void{
      var len:int = listModel.dataProvider.length;
      if(listModel.keyboardFocusedIndex == -1){
        listModel.keyboardFocusedIndex = (listModel.selectedIndex && listModel.selectedIndex != -1)? listModel.selectedIndex:0;
      }
      for(var index:int = 0; index < len; index++){
        if(!canGetFocus(index)){
          continue;
        }
        var t:String = listModel.dataProvider.getItemAt(index).label;
        if(t.indexOf(listModel.keyboardFocusedItem.label) == 0){
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