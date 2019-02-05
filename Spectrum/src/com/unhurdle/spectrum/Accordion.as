package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconType;
  

  public class Accordion extends SpectrumBase
  {

    private var indicator:Icon;

    public function Accordion()
      {
        super();
        typeNames = "spectrum-Accordion"
      }

    private var accordionItem:HTMLDivElement;
    private var headerElem:HTMLDivElement;
    private var itemContent:HTMLDivElement;
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');

      headerElem = newElement("div") as HTMLDivElement;
      headerElem.className = "spectrum-Accordion-itemHeader";
      headerElem.tabIndex = 0;
      elem.appendChild(headerElem);
      var type:String = IconType.CHEVRON_RIGHT_MEDIUM;
      indicator = new Icon(Icon.getCSSTypeSelector(type));
      indicator.type = type;
      addElement(indicator);

      itemContent = newElement("div") as HTMLDivElement;
      itemContent.className = "spectrum-Accordion-itemContent";
      elem.appendChild(itemContent);

      return elem

    }
    
    private var _text:String;

    public function get text():String{
      return _text;
    }

    public function set text(value:String):void{
      _text = value;
    }

    private var _status:String;

    public function get status():String
    {
      return _status;
    }
    
    public function set status(value:String):void
    {
      COMPILE::JS
      {
        if(value != _status){
          switch(value){
            case Accordion.OPEN:
            case Accordion.DISABLED:
            case Accordion.DEFAULT:
              break;
            default:
              throw new Error("Invalid status: " + value);
          }
          var oldStatus:String = valueToSelector(_status);
          var newStatus:String = valueToSelector(value);
          toggle(newStatus, true);
          toggle(oldStatus, false);
          setAccordionType(value);
        }
      }
      _status = value;
    }

  public static const OPEN:String = "open";
  public static const DISABLED:String = "disabled";
  public static const DEFAULT:String = "default";

  public function setAccordionType(status:String):void
  {
    var type:String;

        switch(status){
          case Accordion.OPEN:
          type = " is-open";
          case Accordion.DISABLED:
          type = " is-disabled";
          case Accordion.DEFAULT:
          type = "";
        }
        if(!type){
          type == "";
        }
        if(accordionItem){
          accordionItem.className = "spectrum-Accordion-item" +type;
        } 
        else {
          accordionItem = newElement("div") as HTMLDivElement;
          accordionItem.className = "spectrum-Accordion-item" +type;
          COMPILE::JS{
            element.insertBefore(accordionItem, element.childNodes[0] || null);
          }

        }
        }
  }
}