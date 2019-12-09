package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.supportClasses.TreeListData;
  }

  public class TreeItemRenderer extends DataItemRenderer
  {
    public function TreeItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "pectrum-TreeView" + value;
    }
    override public function updateRenderer():void{
      // do nothing
    }
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      element.className = appendSelector("-item");
      var treeListData:TreeListData = listData as TreeListData;
      if(treeListData.depth != -1){
        this.style = {'marginLeft' :(treeListData.depth - 1) * 30};
      }
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'li');
      return elem;
    }
  }
}