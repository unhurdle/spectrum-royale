package com.unhurdle.spectrum.renderers
{
  import com.unhurdle.spectrum.Icon;
  import com.unhurdle.spectrum.TextNode;

  import org.apache.royale.html.supportClasses.DataItemRenderer;

  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.data.AccordionItem;
  import com.unhurdle.spectrum.newElement;

  public class AccordionItemRenderer extends DataItemRenderer
  {
    public function AccordionItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-Accordion" + value;
    }
		override public function updateRenderer():void{
      // do nothing
    }

    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      var accordionItem:AccordionItem;
      accordionItem = value as AccordionItem;
      element.className = appendSelector("-item");
      if(accordionItem.isOpen){
        element.classList.add("is-open");
      } 
      if(accordionItem.isDisabled){
        element.classList.add("is-disabled");
        element.style.pointerEvents = "none";
      }
      header.text = accordionItem.headerText;
      content.text = accordionItem.contentText;
      itemIsOpen = accordionItem.isOpen;
      createIcon();
    }
    
    COMPILE::JS
    private function handleClick(ev:*):void{
        element.classList.toggle("is-open");
        itemIsOpen = element.classList.contains("is-open");
        content.element.style.display = itemIsOpen?"block":"none";
        createIcon();
    }
    COMPILE::JS
    private function createIcon():void{
      if(indicator){
        div.removeChild(indicator.element);
      }
      type = itemIsOpen? IconType.CHEVRON_DOWN_MEDIUM:IconType.CHEVRON_RIGHT_MEDIUM;
      indicator = new Icon(Icon.getCSSTypeSelector(type));
      indicator.className = appendSelector("-itemIndicator");
      indicator.type = type;
      div.appendChild(indicator.element);
    }
    private var itemIsOpen:Boolean;
    private var header:TextNode;
    private var content:TextNode;
    private var indicator:Icon;
    private var type:String;
    private var div:HTMLDivElement;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      div = newElement('div', appendSelector("-itemHeading")) as HTMLDivElement;
      header = new TextNode("");
      header.element = newElement("div", appendSelector("-itemHeader"));
      div.appendChild(header.element);
      div.addEventListener("click",handleClick);
      elem.appendChild(div);
      content = new TextNode("");
      content.element = newElement("div", appendSelector("-itemContent"));
      elem.appendChild(content.element);
      return elem;
    }
  }
}