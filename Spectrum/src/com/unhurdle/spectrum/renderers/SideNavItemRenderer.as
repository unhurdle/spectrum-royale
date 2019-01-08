package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.data.SideNavItem;
  import com.unhurdle.spectrum.TextNode;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class SideNavItemRenderer extends DataItemRenderer
  {
    public function SideNavItemRenderer()
    {
      super();
      typeNames = '';
    }
    override public function updateRenderer():void{
      // do nothing
    }
    override public function set data(value:Object):void{
      super.data = value;
      var sideNavItem:SideNavItem;
      sideNavItem = value as SideNavItem;
      COMPILE::JS
      {
        element.className = "";
        if(sideNavItem.isHeading){
          textNode.className = "spectrum-SideNav-heading";
        } else {
          element.className = "spectrum-SideNav-item";
        }
        if(sideNavItem.disabled){
          element.classList.add("is-disabled");
        }
        if(sideNavItem.selected){
          element.classList.add("is-selected");
        }
        textNode.text = sideNavItem.text;
      }
    }
    private var textNode:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      textNode = new TextNode("a");
      textNode.className = "spectrum-SideNav-itemLink";
      textNode.element.style.userSelect = "none";
      elem.appendChild(textNode.element);
      return elem;
    }
  }
}