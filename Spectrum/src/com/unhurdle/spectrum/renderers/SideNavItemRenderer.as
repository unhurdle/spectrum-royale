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
  import com.unhurdle.spectrum.Toast;
  import com.unhurdle.spectrum.SideNav;
  import goog.events.Event;

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
      textNode.element.setAttribute("href",sideNavItem.href || "#");
      isList = !!sideNavItem.isList;
      if(isList){
        textNode.text = sideNavItem.text;
        var ul:SideNav = new SideNav();
        ul.dataProvider = sideNavItem.dataProvider;
        ul.multiLevel = (sideNavItem as SideNav).multiLevel;
        addElement(ul);
      }else{
        textNode.text = getLabelFromData(this,value);
      }
      elem.addEventListener("click",sideNavClick);
      if(sideNavItem.disabled){
        elem.classList.add("is-disabled");
        elem.style.pointerEvents = "none";
      }
      if(sideNavItem.selected){
        elem.classList.add("is-selected");
      }
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
    
    private function sideNavClick(event:Event):void{
        var styleStr:String;
         var el:HTMLElement = event.target.closest('.spectrum-SideNav');
        if(el != null && !el.classList.contains("is-selected")){
          event.stopPropagation();
          new Toast("The selected item is: "+event.target.text).show();
        }
      }

    private var textNode:TextNode;
    private var isList:Boolean;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'li');
      textNode = new TextNode("a");
      textNode.className = appendSelector("-itemLink");
      textNode.element.style.userSelect = "none";
      elem.appendChild(textNode.element);
      return elem;
    }
  }
}