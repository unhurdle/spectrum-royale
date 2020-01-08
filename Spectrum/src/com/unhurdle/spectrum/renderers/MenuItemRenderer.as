package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.data.MenuItem;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.Icon;

  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconSize;
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.const.IconPrefix;
  import org.apache.royale.html.util.getLabelFromData;
  // import com.unhurdle.spectrum.data.IMenuItem;
  import com.unhurdle.spectrum.ImageIcon;
  import com.unhurdle.spectrum.Menu;
  import goog.events.Event;

  public class MenuItemRenderer extends DataItemRenderer
  {
    public function MenuItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-Menu" + value;
    }
		override public function updateRenderer():void{
      // do nothing
    }

    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      // var menuItem:IMenuItem;
      // menuItem = value as IMenuItem;
      var menuItem:MenuItem;
      menuItem = value as MenuItem;
      element.className = "";
      if(menuItem.isHeading){
        textNode.className = appendSelector("-sectionHeading");
        element.style.pointerEvents = "none";
      } else {
        element.className = appendSelector("-item");
      }
      if(menuItem.isDivider){
        element.className = appendSelector("-divider");
        element.style.pointerEvents = "none";
      } else {
        // only populate text if it's not a divider
        textNode.text = getLabelFromData(this,value);
      }
      if(menuItem.subMenu){
        // element.classList.add("is-open");
        textNode.text = menuItem.text;
        var ul:Menu = new Menu();
        ul.dataProvider = menuItem.dataProvider;
        addElement(ul);
      } 
      if(menuItem.isOpen){
        element.classList.add("is-open");
      } 
      // if(menuItem.subMenu){
      //   // var nestedType:String = IconType.CHEVRON_RIGHT_MEDIUM;
      //   // var nestedCheckIcon:Icon = new Icon(Icon.getCSSTypeSelector(nestedType));
      //   // nestedCheckIcon.type = nestedType;
      //   // nestedCheckIcon.className = appendSelector("-ChevronRightMedium");
      //   // element.appendChild(nestedCheckIcon.element);
      // }
      element.addEventListener("click",openSubMenu);
      if(menuItem.disabled){
        element.classList.add("is-disabled");
        element.style.pointerEvents = "none";
      }
      if(menuItem.selected){
        element.classList.add("is-selected");
      }
      if(menuItem.icon){
        if(!icon){
          icon = new Icon(menuItem.icon);
          icon.size = IconSize.S;
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
          imageIcon.size = IconSize.S;
          element.insertBefore(imageIcon.element,element.childNodes[0] || null);
          imageIcon.addedToParent();
        } else {
          imageIcon.setStyle("display",null);
          imageIcon.src = menuItem.imageIcon;
        }
      } else if(imageIcon){
        imageIcon.setStyle("display","none");
      }
      itemIsOpen = menuItem.isOpen;
      createIcon();
    }
    
    private function elementHasSubMenu(e:Element):Boolean{
      return e.children.length >2;
    }
    COMPILE::JS
    private function openSubMenu(event:Event):void{
      // var ul:Menu = new Menu();
      // ul.dataProvider = (element as IMenuItem).subMenu;
      // element.classList.add("is-open");
        var el:HTMLElement = event.target.closest('.spectrum-Menu');
        if(el != null && !el.classList.contains("is-selected")){
          event.stopPropagation();
        //   // new Toast("The selected item is: "+event.target.text).show();
        }
      if(elementHasSubMenu(element)){
        element.classList.toggle("is-open");
        itemIsOpen = element.classList.contains("is-open");
        element.children[2].style.display = element.children[2].style.display == "block"?"none":"block";
        // element.children[2].style.visibility = element.children[2].style.visibility == "visible"?"hidden":"visible";
        // element.children[2].style.visibility = element.children[2].style.visibility == "visible"?"hidden":"visible";
        // element.children[2].hidden = !element.children[2].hidden;
      }
      createIcon()
    }
    COMPILE::JS
    private function createIcon():void{
      if(elementHasSubMenu(element)){
        if(indicator){
          removeElement(indicator);
        }
        type = itemIsOpen? IconType.CHEVRON_DOWN_MEDIUM:IconType.CHEVRON_RIGHT_MEDIUM;
        indicator = new Icon(Icon.getCSSTypeSelector(type));
        indicator.className = appendSelector("-itemIndicator");
        indicator.type = type;
        // addElement(indicator);
        element.insertBefore(indicator.element,element.firstElementChild());
      }
    }
    private function elementParentIsMultiLevel(e:Element):Boolean{
      // this.element.parentElement.parentElement.classList.contains("spectrum-Menu") || this.element.parentElement.parentElement.classList.contains("spectrum-MenuItem")
      return e.parentElement.classList.contains("spectrum-Menu") && !e.parentElement.parentElement.classList.contains("spectrum-Menu-item");
      // return e.parentElement.classList.contains("spectrum-Menu") || e.parentElement.classList.contains("spectrum-Menu-item");
    }
    private function removeSelectedFromOtherLevel(list:*):void{
      for (var i:int = 0; i < list.length; i++){
        var ch:Element = list[i];
        if(ch.classList.contains("is-selected")){
          ch.classList.remove("is-selected")
          return;
        }
        if(elementHasSubMenu(ch)){
          removeSelectedFromOtherLevel(ch.children[2].children);
        }
        // if(elementParentIsMultiLevel(ch) || elementParentIsSideNavItem(ch)){
        //   removeSelectedFromOtherLevel(ch.parentElement.children);
        // }
      }
    }
    override public function set selected(value:Boolean):void{
      super.selected = value;
      COMPILE::JS
      {
        // if(value){
        //     element.classList.add("is-selected");
        // } else {
        //   element.classList.remove("is-selected");
        // }
        if(value && !elementHasSubMenu(element)){
          var elemWithListToRemove:Element = element;
          // while(elementParentIsMultiLevel(elemWithListToRemove)){
          while(!elementParentIsMultiLevel(elemWithListToRemove)){
            elemWithListToRemove = elemWithListToRemove.parentElement;
            // elemWithListToRemove = elemWithListToRemove.parentElement.parentElement;
          }
          removeSelectedFromOtherLevel(elemWithListToRemove.parentElement.children);
          // if(){
            element.classList.add("is-selected");
          // }
        } 
      }
    }
    private var icon:Icon;
    private var imageIcon:ImageIcon;
    private var textNode:TextNode;
    private var indicator:Icon;
    private var type:String;
    private var itemIsOpen:Boolean;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'li');
      textNode = new TextNode("span");
      textNode.className = appendSelector("-itemLabel");
      textNode.element.style.userSelect = "none";
      elem.appendChild(textNode.element);
      var type:String = IconType.CHECKMARK_MEDIUM;
      var checkIcon:Icon = new Icon(IconPrefix.SPECTRUM_CSS_ICON + type);
      checkIcon.type = type;
      checkIcon.className = appendSelector("-checkmark");
      addElement(checkIcon);

      return elem;
    }

  }
}