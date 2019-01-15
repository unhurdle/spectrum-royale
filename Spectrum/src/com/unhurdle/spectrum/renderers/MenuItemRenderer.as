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
    private var icon:Icon;
    private var textNode:TextNode;
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