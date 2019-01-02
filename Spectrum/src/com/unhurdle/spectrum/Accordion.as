package com.unhurdle.spectrum
{
  COMPILE::JS{
  import org.apache.royale.html.util.addElementToWrapper;
  import org.apache.royale.core.WrappedHTMLElement;
  }
  

  COMPILE::SWF
  public class Accordion extends SpectrumBase
  {
    
  }
  COMPILE::JS
  public class Accordion extends SpectrumBase
  {
  // COMPILE::SWF
  // private var accordionItem:HTMLDivElement;
  // COMPILE::SWF
  // private var headerElem:HTMLDivElement; //ability to be opened closed disabled
  // COMPILE::SWF
  // private var indicator:SVGElement;
  // COMPILE::SWF
  // private var indicatorIcon:SVGUseElement;
  // COMPILE::SWF
  // private var itemContent:HTMLDivElement;

  public function Accordion()
    {
      super();
      typeNames = "spectrum-Accordion"
    }

  COMPILE::JS
  private var accordionItem:HTMLDivElement;
  COMPILE::JS
  private var headerElem:HTMLDivElement;
  COMPILE::JS
  private var indicator:SVGElement;
  COMPILE::JS
  private var indicatorIcon:SVGUseElement;
  COMPILE::JS
  private var itemContent:HTMLDivElement;
  
  COMPILE::JS
  override protected function createElement():WrappedHTMLElement{
    var elem:WrappedHTMLElement = addElementToWrapper(this,'div');

    headerElem = newElement("div") as HTMLDivElement;
    headerElem.className = "spectrum-Accordion-itemHeader";
    headerElem.tabIndex = 0;
    elem.appendChild(headerElem);
  
    indicator = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
    indicator.className = "spectrum-Icon spectrum-UIIcon-ChevronRightMedium spectrum-Accordion-itemIndicator";
    indicator.setAttribute("focusable",false);
    elem.appendChild(indicator);

    indicatorIcon = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
    indicatorIcon.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-ChevronRightMedium');
    indicator.appendChild(indicatorIcon);

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
        var oldStatus:String = valueToCSS(_status);
        var newStatus:String = valueToCSS(value);
        toggle(newStatus, true);
        toggle(oldStatus, false);
        setAccordionType(value);
      }
    }
    _status = value;
  }
  COMPILE::JS
private function valueToCSS(status:String):String{
  return "spectrum-Accordion-item" + status;
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
        element.insertBefore(accordionItem, element.childNodes[0] || null);

      }
      
}
  }
}