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

  public class MenuItemRenderer extends DataItemRenderer
  {
    public function MenuItemRenderer()
    {
      super();
      typeNames = '';
    }
		override public function updateRenderer():void{
      // do nothing
    }

    override public function set data(value:Object):void{
      var menuItem:MenuItem;
      menuItem = value as MenuItem;
      COMPILE::JS
      {
        element.className = "";
        if(menuItem.isHeading){
          textNode.className = "spectrum-Menu-sectionHeading";
        } else {
          element.className = "spectrum-Menu-item";
        }
        if(menuItem.isDivider){
          element.className = "spectrum-Menu-divider";
        }
        if(menuItem.disabled){
          element.classList.add("is-disabled");
        }
        if(menuItem.selected){
          element.classList.add("is-selected");
        }
        textNode.text = menuItem.text;

        if(menuItem.icon){
          if(!icon){
            icon = new Icon(menuItem.icon);
            icon.className = "spectrum-Icon spectrum-Icon--sizeS";
            element.insertBefore(icon.getElement(),element.childNodes[0] || null);
          } else {
            icon.getElement().style.display = null;
            icon.selector = menuItem.icon;
          }
        } else if(icon){
          icon.getElement().style.display = "none";
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
      textNode.className = "spectrum-Menu-itemLabel";
      elem.appendChild(textNode.element);
      var checkIcon:Icon = new Icon("#spectrum-css-icon-CheckmarkMedium");
      checkIcon.className = "spectrum-Icon spectrum-UIIcon-CheckmarkMedium spectrum-Menu-checkmark";
      elem.appendChild(checkIcon.getElement());

      return elem;
    }

  }
}