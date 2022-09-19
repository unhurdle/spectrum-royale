package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.data.MenuItem;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.Icon;

  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.const.IconPrefix;
  import org.apache.royale.html.util.getLabelFromData;
  // import com.unhurdle.spectrum.data.IMenuItem;
  import com.unhurdle.spectrum.ImageIcon;
  import com.unhurdle.spectrum.Menu;
  import org.apache.royale.events.Event;

  public class MenuItemRenderer extends DataItemRenderer
  {
    public function MenuItemRenderer()
    {
      super();
      typeNames = "";
    }
    override protected function getSelector():String{
      return "spectrum-Menu";
    }
    private var submenu:Menu;
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      // var menuItem:IMenuItem;
      // menuItem = value as IMenuItem;
      var menuItem:MenuItem;
      menuItem = value as MenuItem;
      // element.className = "";
      toggle(appendSelector("-sectionHeading"),menuItem.isHeading);
      var isItem:Boolean = !menuItem.isHeading && !menuItem.isDivider;
      toggle(appendSelector("-item"),isItem);
      // if(menuItem.isHeading){
        // element.style.pointerEvents = "none";
      // }
      toggle(appendSelector("-divider"),menuItem.isDivider);
      if(menuItem.isDivider){
        // element.style.pointerEvents = "none";
      } else {
        // only populate text if it's not a divider
        textNode.text = getLabelFromData(this,value);
      }
      if(menuItem.subMenu && menuItem.isOpen){
        submenu = new Menu();
        submenu.dataProvider = menuItem.subMenu;
        addElement(submenu);
      } 
      toggle("is-open",menuItem.isOpen);
      // if(menuItem.subMenu){
      //   // var nestedType:String = IconType.CHEVRON_RIGHT_MEDIUM;
      //   // var nestedCheckIcon:Icon = new Icon(Icon.getCSSTypeSelector(nestedType));
      //   // nestedCheckIcon.type = nestedType;
      //   // nestedCheckIcon.className = appendSelector("-ChevronRightMedium");
      //   // element.appendChild(nestedCheckIcon.element);
      // }
      addEventListener("click",openSubMenu);
      disabled = menuItem.disabled;
      if(menuItem.icon){
        if(!icon){
          icon = new Icon(menuItem.icon);
          element.insertBefore(icon.element,element.childNodes[0] || null);
          icon.addedToParent();
        } else {
          icon.setStyle("display",null);
          icon.selector = menuItem.icon;
        }
      } else if(icon){
        icon.setStyle("display","none");
      }
      if(menuItem.imageIcon){
        if(!imageIcon){
          imageIcon = new ImageIcon(menuItem.imageIcon);
          element.insertBefore(imageIcon.element,element.childNodes[0] || null);
          imageIcon.addedToParent();
        } else {
          imageIcon.setStyle("display",null);
          imageIcon.src = menuItem.imageIcon;
        }
      } else if(imageIcon){
        imageIcon.setStyle("display","none");
      }
      createIcon();
    }
    
    private function elementHasSubMenu(e:Element):Boolean{
      //TODO for now we're not supporting submenus
      return false;
    }
    COMPILE::JS
    private function openSubMenu(event:Event):void{

        // var el:HTMLElement = event.target.closest('.spectrum-Menu');
        // if(el != null && !el.classList.contains("is-selected")){
        //   event.stopPropagation();
        // //   // new Toast("The selected item is: "+event.target.text).show();
        // }
      if(data is MenuItem){
        var menuItem:MenuItem = data as MenuItem;
        if(menuItem.subMenu){
          menuItem.isOpen = !menuItem.isOpen;
          toggle("is-open",menuItem.isOpen);
          if(menuItem.isOpen){
            if(!submenu){
              submenu = new Menu();
              submenu.dataProvider = menuItem.subMenu;
              addElement(submenu);
            }
          } else {
            removeElement(submenu);
            submenu = null;
          }
        }
        createIcon();
      }
    }
    COMPILE::JS
    private function createIcon():void{
      var menuItem:MenuItem = data as MenuItem;
      if(menuItem.subMenu){
        type = (data as MenuItem).isOpen? IconType.CHEVRON_DOWN_MEDIUM:IconType.CHEVRON_RIGHT_MEDIUM;
        if(indicator){
          indicator.selector = Icon.getCSSTypeSelector(type);
        } else {
          indicator = new Icon(Icon.getCSSTypeSelector(type));
          indicator.toggle(appendSelector("-chevron"),true);
          indicator.toggle(appendSelector("-itemIcon"),true);
          addElement(indicator);
        }
        indicator.type = type;

      }
      if(elementHasSubMenu(element)){
        if(indicator){
          removeElement(indicator);
        }
        indicator = new Icon(Icon.getCSSTypeSelector(type));
        indicator.toggle(appendSelector("-itemIndicator"),true);
        indicator.type = type;
        // addElement(indicator);
        element.insertBefore(indicator.element,element.firstElementChild);
      }
    }
    //TODO deal with sub-menus
    // private function elementParentIsMultiLevel(e:Element):Boolean{
    //   // this.element.parentElement.parentElement.classList.contains("spectrum-Menu") || this.element.parentElement.parentElement.classList.contains("spectrum-MenuItem")
    //   return e.parentElement.classList.contains("spectrum-Menu") && !e.parentElement.parentElement.classList.contains("spectrum-Menu-item");
    //   // return e.parentElement.classList.contains("spectrum-Menu") || e.parentElement.classList.contains("spectrum-Menu-item");
    // }
    //TODO deal with sub-menus
    // private function removeSelectedFromOtherLevel(list:*):void{
    //   for (var i:int = 0; i < list.length; i++){
    //     var ch:Element = list[i];
    //     if(ch.classList.contains("is-selected")){
    //       ch.classList.remove("is-selected")
    //       return;
    //     }
    //     if(elementHasSubMenu(ch)){
    //       removeSelectedFromOtherLevel(ch.children[2].children);
    //     }
    //     // if(elementParentIsMultiLevel(ch) || elementParentIsSideNavItem(ch)){
    //     //   removeSelectedFromOtherLevel(ch.parentElement.children);
    //     // }
    //   }
    // }
    override public function set selected(value:Boolean):void{
      super.selected = value;
      if(value){
        checkIcon.setStyle("display",null);
        //set the color of the text to the color of the checkmark ? rgb(20, 115, 230) #1473e6
      }else{
        checkIcon.setStyle("display","none");
      }

    }
    //TODO deal with sub-menus
    // override public function set selected(value:Boolean):void{
    //   super.selected = value;
    //   COMPILE::JS
    //   {
    //     // if(value){
    //     //     element.classList.add("is-selected");
    //     // } else {
    //     //   element.classList.remove("is-selected");
    //     // }
    //     if(value && !elementHasSubMenu(element)){
    //       var elemWithListToRemove:Element = element;
    //       // while(elementParentIsMultiLevel(elemWithListToRemove)){
    //       while(!elementParentIsMultiLevel(elemWithListToRemove)){
    //         elemWithListToRemove = elemWithListToRemove.parentElement;
    //         // elemWithListToRemove = elemWithListToRemove.parentElement.parentElement;
    //       }
    //       removeSelectedFromOtherLevel(elemWithListToRemove.parentElement.children);
    //       // if(){
    //         // element.classList.add("is-selected");
    //       // }
    //     } 
    //   }
    // }
    protected var icon:Icon;
    protected var imageIcon:ImageIcon;
    protected var textNode:TextNode;
    private var indicator:Icon;
    private var type:String;
    private var checkIcon:Icon;

    override protected function getTag():String{
      return "li";
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = super.createElement();
      textNode = new TextNode("span");
      textNode.className = appendSelector("-itemLabel");
      textNode.element.style.userSelect = "none";
      elem.appendChild(textNode.element);
      var type:String = IconType.CHECKMARK_MEDIUM;
      checkIcon = new Icon(IconPrefix.SPECTRUM_CSS_ICON + type);
      checkIcon.type = type;
      checkIcon.className = appendSelector("-checkmark");
      checkIcon.setStyle("display","none");
      addElement(checkIcon);


      return elem;
    }

  }
}