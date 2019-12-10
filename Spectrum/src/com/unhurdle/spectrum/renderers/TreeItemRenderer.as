package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.supportClasses.TreeListData;
    import org.apache.royale.events.ValueEvent;
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
      addEventListener("setSelected",setSelected);
      var treeListData:TreeListData = listData as TreeListData;
      if(treeListData.depth != -1){
        this.style = {'marginLeft' :(treeListData.depth - 1) * 30};
      }
    }
    COMPILE::JS
    private function setSelected(ev:ValueEvent):void
    {
      var children:NodeList = element.parentElement.children;
      for(var i:int = 0;i<children.length;i++){
        if(children[i].style.background == 'rgb(55, 142, 240)'){
          children[i].style.background = 'none';
          break;
        }
      }
      if(ev.value){
        element.style.background = 'rgb(55, 142, 240)';
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