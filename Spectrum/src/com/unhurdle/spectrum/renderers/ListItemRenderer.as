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
    import com.unhurdle.spectrum.Application;
  }

  public class ListItemRenderer extends DataItemRenderer
  {
    public function ListItemRenderer()
    {
      super();
      typeNames = 'spectrum-Menu-item';
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
          if(!icon){
            icon = new Icon(value["icon"]);
            icon.className = "spectrum-Icon spectrum-Icon--sizeS";
            element.insertBefore(icon.getElement(),element.childNodes[0] || null);
          } else {
            icon.getElement().style.display = null;
            icon.selector = value["icon"];
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
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      textNode = new TextNode("span");
      textNode.className = "spectrum-Menu-itemLabel";
      textNode.element.style.userSelect = "none";
      elem.appendChild(textNode.element);
      var checkIcon:Icon = new Icon("#spectrum-css-icon-CheckmarkMedium");
      checkIcon.className = "spectrum-Icon spectrum-UIIcon-CheckmarkMedium spectrum-Menu-checkmark";
      elem.appendChild(checkIcon.getElement());

      return elem;
    }

  }
}