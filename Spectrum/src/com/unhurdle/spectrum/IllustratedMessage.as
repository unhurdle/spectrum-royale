package com.unhurdle.spectrum
{
  COMPILE::JS{
  import org.apache.royale.html.util.addElementToWrapper;
  import org.apache.royale.core.WrappedHTMLElement;
 
  
  }
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.typography.PageTitle;
  import com.unhurdle.spectrum.typography.TypographyBase;


  public class IllustratedMessage extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/illustratedmessage/dist.css">
     * </inject_html>
     * 
     */
    public function IllustratedMessage() 
    {
      super();
      if(!type){
         type = "default";
      }
     
    }

    override protected function getSelector():String{
      return "spectrum-IllustratedMessage";
    }

    private var _type:String;
    private var header:PageTitle;
    private var paragraph:TextNode;
    public var hyperlink:TextNode;

    public function get type():String
    {
        return _type;
    }
        
        
    public function set type(value:String):void //change to type :type
    {
        if(!value){
        type("default");
      }
      if(value != _type){
        switch(value){
          case "cta":
            ofTypeCTA(); 
          break;  
          case "default":
            defaultType();
            break;
          case "overBackground":
            break;
          default:
            throw new Error("Unexpected flavor: " + value);
        }
      }
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      addElementToWrapper(this,'div');
      element.appendChild(generateSVG(predefinedSVGElement()));

      header = new PageTitle(); 
      header.element.classList.add("spectrum-IllustratedMessage-heading");
      header.element.classList.add("spectrum-heading");
      header.element.classList.add(header.typeNames);
      
      element.appendChild(header.element);

      paragraph = new TextNode("p");
      paragraph.className = "spectrum-Body--secondary spectrum-IllustratedMessage-description";
      element.appendChild(paragraph.element);

      return element;
    }

    private function ofTypeCTA():void //pg text needs HELP
    {
      header.text = "Drag and Drop Your File";
      paragraph.text = "" ; //problem 
      hyperlink = new TextNode("a");
      (hyperlink as HTMLLinkElement).href ="#"; 
      hyperlink.className = "spectrum-Link";
      hyperlink.text = "Select a File"; 
      
      // paragraph.text = "or "; 
      
      paragraph.element.appendChild(hyperlink.element);
      // paragraph.text = "from your computer ";  
      
      var br:HTMLElement = newElement("br");
      paragraph.element.appendChild(br);
      
    }

    private function defaultType():void
    {
      header.text = "Error 404: Page Not Found";
      paragraph.text = "This page isn't available. Try checking the URL or visit a different page.";
      
    }
  }
}