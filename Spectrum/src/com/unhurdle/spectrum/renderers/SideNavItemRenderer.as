package com.unhurdle.spectrum.renderers
{
  import com.unhurdle.spectrum.data.SideNavItem;
  import com.unhurdle.spectrum.TextNode;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.SideNav;
  import com.unhurdle.spectrum.Toast;
  import goog.events.Event;
  import com.unhurdle.spectrum.Icon;
  import com.unhurdle.spectrum.const.IconSize;
  import com.unhurdle.spectrum.ImageIcon;

  public class SideNavItemRenderer extends DataItemRenderer
  {
    public function SideNavItemRenderer()
    {
      super();
      typeNames = '';
    }
    override protected function appendSelector(value:String):String{
      return "spectrum-SideNav" + value;
    }
    override public function updateRenderer():void{
      // do nothing
    }

    COMPILE::JS
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
        if(value){
          // if(elementParentIsSideNavItem(element)){
          //   element.parentElement.parentElement.classList.remove("is-selected");
          //   removeSelectedFromOtherLevel(element.parentElement.parentElement.parentElement.children);
          // }else if(elementParentIsMultiLevel(element) || elementParentIsSideNavItem(element)){
          //   var array:* = element.parentElement.children;
          //   for(var index:int = 0; index < array.length; index++){
          //     var elem:Element = array[index];
          //     if(elementHasSideNav(elem)){
          //       removeSelectedFromOtherLevel(elem.children[1].children);
          //       // break;
          //     }
          //   }
          // }
          var elemWithListToRemove:Element = element;
          while(!elementParentIsMultiLevel(elemWithListToRemove)){
            //  elementParentIsSideNavItem(elemWithListToRemove)
            // trace("elemWithListToRemove.parentElement");
            // trace(elemWithListToRemove.parentElement);
            // trace("elemWithListToRemove.parentElement.parentElement");
            // trace(elemWithListToRemove.parentElement.parentElement);
            elemWithListToRemove = elemWithListToRemove.parentElement.parentElement;
          }
          removeSelectedFromOtherLevel(elemWithListToRemove.parentElement.children);
          element.classList.add("is-selected");
        } 
        // else {
        //   element.classList.remove("is-selected");
        //   if(elementHasSideNav(element)){
        //     // for each(var ch:Element in element.children[1].children){
        //     //   if(ch.classList.contains("is-selected")){
        //     //     ch.classList.remove("is-selected")
        //     //     return;
        //     //   }
        //     // }
        //     removeSelectedFromOtherLevel(element.children[1].children);
        //   }
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
        var styleStr:String;
        var el:HTMLElement = event.target.closest('.spectrum-SideNav');
        if(el != null && !el.classList.contains("is-selected")){
          event.stopPropagation();
          new Toast("The selected item is: "+event.target.text).show();
        }
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