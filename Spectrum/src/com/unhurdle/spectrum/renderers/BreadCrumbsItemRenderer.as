package com.unhurdle.spectrum.renderers
{

  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.Icon;
  import org.apache.royale.html.util.getLabelFromData;

  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class BreadCrumbsItemRenderer extends DataItemRenderer
  {
    public function BreadCrumbsItemRenderer()
    {
      super();
      typeNames = '';
    }
		override public function updateRenderer():void{
      // do nothing
    }

    override public function set data(value:Object):void{
      super.data = value;
      textNode.text = getLabelFromData(this,value);
      COMPILE::JS{
        element.className = "spectrum-Breadcrumbs-item";
      }
    }
    private var icon:Icon;
    private var textNode:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      textNode = new TextNode("a");
      textNode.className = "spectrum-Breadcrumbs-itemLink";
      elem.appendChild(textNode.element);
      icon = new Icon("#spectrum-css-icon-ChevronRightSmall");
      icon.className = "spectrum-Icon spectrum-UIIcon-ChevronRightSmall spectrum-Breadcrumbs-itemSeparator";
      element.appendChild(icon.getElement());
      return elem;
    }
  }
}