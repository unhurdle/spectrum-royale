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
  import org.apache.royale.html.util.getLabelFromData;
  public class SideNavItemRenderer extends DataItemRenderer
  {
    public function SideNavItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-SideNav" + value;
    }
    override public function updateRenderer():void{
      // do nothing
    }

    override public function set data(value:Object):void{
      super.data = value;
      var elem:HTMLElement = element as HTMLElement;
      var sideNavItem:SideNavItem = value as SideNavItem;
      elem.className = null;
      elem.style.pointerEvents = null
      if(sideNavItem.isHeading){
        textNode.className = appendSelector("-heading");
        elem.style.pointerEvents = "none";
      } else {
        elem.className = appendSelector("-item");
      }
      if(sideNavItem.disabled){
        elem.classList.add("is-disabled");
        elem.style.pointerEvents = "none";
      }
      if(sideNavItem.selected){
        elem.classList.add("is-selected");
      }
      textNode.text = getLabelFromData(this,value);
    }
    override public function set selected(value:Boolean):void{
      super.selected = value;
      COMPILE::JS
      {
        if(value){
          element.classList.add("is-selected");
        } else {
          element.classList.remove("is-selected");
        }
      }
    }
    private var textNode:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      textNode = new TextNode("a");
      textNode.className = appendSelector("-itemLink");
      textNode.element.style.userSelect = "none";
      elem.appendChild(textNode.element);
      return elem;
    }
  }
}