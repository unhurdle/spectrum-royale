package com.unhurdle.spectrum.renderers
{

  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.Icon;
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.data.BreadcrumbsItem;

  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import com.unhurdle.spectrum.newElement;
    import org.apache.royale.events.ValueEvent;
    import org.apache.royale.events.IEventDispatcher;
  }
  
  public class BreadcrumbsItemRenderer extends DataItemRenderer
  {
    public function BreadcrumbsItemRenderer()
    {
      super();
      typeNames = '';
    }
		override public function updateRenderer():void{
      // do nothing
    }

    override public function set data(value:Object):void{
      super.data = value
      if(value is BreadcrumbsItem){
        var breadCrumbsItem:BreadcrumbsItem;
        breadCrumbsItem = value as BreadcrumbsItem;
        textNode.text = breadCrumbsItem.text;
      }
      else{
        textNode.text = getLabelFromData(this,value);
      }
      COMPILE::JS{
        element.className = "spectrum-Breadcrumbs-item";
        if(breadCrumbsItem && breadCrumbsItem.isTitle){
          var h1:HTMLElement = newElement("h1");
          h1.className = "spectrum-Heading--pageTitle";
          element.removeChild(textNode.element);
          element.removeChild(icon.getElement());
          h1.appendChild(textNode.element);
          element.appendChild(h1);
        }
      }
    }
    override public function set selected(value:Boolean):void{
      super.selected = value;
      COMPILE::JS
      {
        if(value){
          (parent as IEventDispatcher).dispatchEvent(new ValueEvent("selected",element));
        } 
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