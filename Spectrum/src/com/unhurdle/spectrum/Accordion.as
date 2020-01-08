package com.unhurdle.spectrum
{
  COMPILE::JS{
      import org.apache.royale.core.WrappedHTMLElement;
      import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.html.List;

  public class Accordion extends org.apache.royale.html.List
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/accordion/dist.css">
     * </inject_html>
     * 
     */

    public function Accordion()
    {
      super();
      typeNames = getSelector();
    }

    private var indicator:Icon;
    private var accordionItem:HTMLDivElement;
    private var headerElem:HTMLDivElement;
    private var itemContent:HTMLDivElement;
    
    

    private function getSelector():String{
      return "spectrum-Accordion";
    }

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
  }
}