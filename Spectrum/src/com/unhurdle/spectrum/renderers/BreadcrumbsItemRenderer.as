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
  }
  import org.apache.royale.events.ValueEvent;
  import org.apache.royale.events.IEventDispatcher;
  import com.unhurdle.spectrum.const.IconType;
  
  public class BreadcrumbsItemRenderer extends DataItemRenderer
  {
    public function BreadcrumbsItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-Breadcrumbs" + value;
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
        element.className = appendSelector("-item");
        if(breadCrumbsItem && breadCrumbsItem.isTitle){
          var h1:HTMLElement = newElement("h1");
          h1.className = "spectrum-Heading--pageTitle";
          // element.removeChild(textNode.element);
          removeElement(icon);
          // element.removeChild(icon.getElement());
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
      textNode.className = appendSelector("-itemLink");
      elem.appendChild(textNode.element);
      var type:String = IconType.CHEVRON_RIGHT_SMALL;
      icon = new Icon(Icon.getCSSTypeSelector(type));
      icon.type = type;
      icon.className = appendSelector("-itemSeparator");
      addElement(icon);
      return elem;
    }
  }
}