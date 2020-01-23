package com.unhurdle.spectrum.renderers
{
  import com.unhurdle.spectrum.data.SideNavItem;
  import com.unhurdle.spectrum.TextNode;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import goog.events.Event;
  import com.unhurdle.spectrum.Icon;
  import com.unhurdle.spectrum.ImageIcon;
  import com.unhurdle.spectrum.data.MenuItem;
  import org.apache.royale.html.supportClasses.TreeListData;

  public class SideNavItemRenderer extends DataItemRenderer
  {
    public function SideNavItemRenderer()
    {
      super();
      typeNames = '';
    }
    override protected function getSelector():String{
      return "spectrum-SideNav";
    }
    public static var indent:Number = 10;
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      var elem:HTMLElement = element as HTMLElement;
      if(value is MenuItem){
        var menuItem:MenuItem = value as MenuItem;
        if(menuItem.isHeading){
          toggle(appendSelector("-heading"),true);
          toggle(appendSelector("-item"),false);
        } else {
          toggle(appendSelector("-heading"),false);
          toggle(appendSelector("-item"),true);
        }
      }

      if(listData is TreeListData){
        var treeListData:TreeListData = listData as TreeListData;
        var indentVal:String = "";
        if(treeListData.depth != -1){
          
          indentVal = (treeListData.depth - 1) * indent + "px";
        }
        element.style.marginLeft = indentVal;
      }

      var sideNavItem:SideNavItem = value as SideNavItem;
      textNode.text = sideNavItem.text;
      // elem.style.pointerEvents = null
      // textNode.element.setAttribute("href",sideNavItem.href || "#");
      //TODO nested lists?
      // isList = !!sideNavItem.isList;
      // if(isList){
      //   textNode.text = sideNavItem.text;
      //   var ul:SideNav = new SideNav();
      //   ul.dataProvider = sideNavItem.dataProvider;
      //   ul.multiLevel = (sideNavItem as SideNav).multiLevel;
      //   addElement(ul);
      // }else{
      //   textNode.text = getLabelFromData(this,value);
      // }
      elem.addEventListener("click",sideNavClick);
      if(sideNavItem.icon && !elementParentIsSideNavItem(elem)){
        if(!icon){
          icon = new Icon(sideNavItem.icon);
          element.insertBefore(icon.element,element.childNodes[0] || null);
          icon.addedToParent();
        } else {
          icon.setStyle("display",null);
          icon.selector = sideNavItem.icon;
        }
      } else if(icon){
        icon.setStyle("display","none");
      }
      if(sideNavItem.imageIcon && !elementParentIsSideNavItem(elem)){
        if(!imageIcon){
          imageIcon = new ImageIcon(sideNavItem.imageIcon);
          elem.insertBefore(imageIcon.element,element.childNodes[0] || null);
          imageIcon.addedToParent();
        } else {
          imageIcon.setStyle("display",null);
          imageIcon.src = sideNavItem.imageIcon;
        }
      } else if(imageIcon){
        imageIcon.setStyle("display","none");
      }
    }
    private function elementHasSideNav(e:Element):Boolean{
      return e.children.length >1;
    }
    private function elementParentIsSideNavItem(e:Element):Boolean{
      return e.parentElement.parentElement.classList.contains(appendSelector("-item"));
    }
    private function elementParentIsMultiLevel(e:Element):Boolean{
      return e.parentElement.classList.contains(appendSelector("--multiLevel"));
    }
    override public function set selected(value:Boolean):void{
      super.selected = value;
      COMPILE::JS
      {
        // if(value){
        //   var elemWithListToRemove:Element = element;
        //   while(!elementParentIsMultiLevel(elemWithListToRemove)){
        //     elemWithListToRemove = elemWithListToRemove.parentElement.parentElement;
        //   }
        //   removeSelectedFromOtherLevel(elemWithListToRemove.parentElement.children);
        // } 
      }
    }
    private function removeSelectedFromOtherLevel(list:*):void{
      for (var i:int = 0; i < list.length; i++){
        var ch:Element = list[i];
        if(ch.classList.contains("is-selected")){
          ch.classList.remove("is-selected")
          return;
        }
        if(elementHasSideNav(ch)){
          removeSelectedFromOtherLevel(ch.children[1].children);
        }
        // if(elementParentIsMultiLevel(ch) || elementParentIsSideNavItem(ch)){
        //   removeSelectedFromOtherLevel(ch.parentElement.children);
        // }
      }
    }
    private function sideNavClick(event:Event):void{
        COMPILE::JS
        {
          if(elementHasSideNav(element)){
            element.children[1].hidden = !element.children[1].hidden;
          }
        }
      }
    private var icon:Icon;
    private var imageIcon:ImageIcon;
    private var textNode:TextNode;
    private var isList:Boolean;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'li');
      // var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      textNode = new TextNode("a");
      textNode.className = appendSelector("-itemLink");
      textNode.element.style.userSelect = "none";
      textNode.element.style.display = "inline";
      elem.appendChild(textNode.element);
      return elem;
    }
  }
}