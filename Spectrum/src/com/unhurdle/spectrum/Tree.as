package com.unhurdle.spectrum
{
  import org.apache.royale.html.Tree;
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class Tree extends org.apache.royale.html.Tree
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/treeview/dist.css">
     * </inject_html>
     * 
     */
    public function Tree()
    {
      super();
      typeNames = "spectrum-TreeView"
    }
    override public function set dataProvider(value:Object):void{
      super.dataProvider = value;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'ul');
    }
  }
}