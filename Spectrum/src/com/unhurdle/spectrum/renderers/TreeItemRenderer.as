package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.supportClasses.TreeListData;
    import org.apache.royale.events.ValueEvent;
  }

  public class TreeItemRenderer extends ListItemRenderer
  {
    public function TreeItemRenderer()
    {
      super();
      typeNames = '';
    }
    public static var indent:Number = 10;
    override protected function getSelector():String{
      return "spectrum-TreeView";
    }
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      toggle(appendSelector("-item"),true);
      if(listData is TreeListData){
        var treeListData:TreeListData = listData as TreeListData;
        var indentVal:String = "";
        if(treeListData.depth != -1){
          
          indentVal = (treeListData.depth - 1) * indent + "px";
        }
        element.style.marginLeft = indentVal;
      }
    }
    // COMPILE::JS
    // override public function set selected(value:Boolean):void
    // {
    //   super.selected = value;
    //   //TODO can we avoid writing these style directly?
    //   var background:String = "";
    //   if(value){
    //     background = 'rgb(55, 142, 240)';
    //   }
    //   element.style.background = background;
    // }
  }
}