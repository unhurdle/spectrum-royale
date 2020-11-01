package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.html.supportClasses.TreeListData;

  public class TreeItemRendererBase extends ListItemRenderer
  {
    public function TreeItemRendererBase()
    {
      super();
      typeNames = '';
    }
    private var children:Array;
    public static var indent:Number = 10;
    override protected function getSelector():String{
      return "spectrum-TreeView";
    }
    private var treeListData:TreeListData;
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      children = value.children;
      toggle(appendSelector("-item"),true);
      if(listData is TreeListData){
        treeListData = listData as TreeListData;
        var indentVal:String = "";
        if(treeListData.depth != -1){
          indentVal = (treeListData.depth - 1) * indent + "px";
        }
        element.style.paddingLeft = indentVal;
        if(icon){
          icon.toggle(appendSelector('-itemIcon'),true);
        }
      }
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,getTag());
      return elem;
    }
  }
}