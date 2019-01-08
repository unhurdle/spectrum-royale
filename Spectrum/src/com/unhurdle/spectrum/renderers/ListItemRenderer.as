package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.data.MenuItem;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.Icon;

  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.Application;
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.const.IconSize;

  public class ListItemRenderer extends DataItemRenderer
  {
    public function ListItemRenderer()
    {
      super();
      typeNames = appendSelector('-item');
    }
    protected function appendSelector(value:String):String{
      return "spectrum-Menu" + value;
    }
		override public function updateRenderer():void{
      COMPILE::JS
      {
        // Hover is handled by the css classes
				if (selected){
					element.style.backgroundColor = Application.getSelectionColor();
          element.style.color = "#FFFFFF";
        } else {
          element.style.backgroundColor = null;
          element.style.color = null
        }

      }
    }

    override public function set data(value:Object):void{
      super.data = value;
      textNode.text = getLabelFromData(this,value);
      COMPILE::JS
      {
        if(value["icon"]){
          var iconSelector:String = value["icon"];
          if(!icon){
            icon = new Icon(iconSelector);
            icon.size = IconSize.S;
            element.insertBefore(icon.element,element.childNodes[0] || null);
            icon.addedToParent();
          } else {
            icon.element.style.display = null;
            icon.selector = iconSelector;
          }
        } else if(icon){
          icon.element.style.display = "none";
        }

      }

    }
    private var icon:Icon;
    private var textNode:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      textNode = new TextNode("span");
      textNode.className = appendSelector("-itemLabel");
      textNode.element.style.userSelect = "none";
      elem.appendChild(textNode.element);
      var type:String = IconType.CHECKMARK_MEDIUM;
      var checkIcon:Icon = new Icon(Icon.getCSSTypeSelector(type));
      checkIcon.type = type;
      checkIcon.className = appendSelector("-checkmark");
      addElement(checkIcon);
      return elem;
    }

  }
}