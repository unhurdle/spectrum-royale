package com.unhurdle.spectrum
{
  COMPILE::JS{
  import org.apache.royale.html.util.addElementToWrapper;
  import org.apache.royale.core.WrappedHTMLElement;
 
  
  }
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.typography.PageTitle;
  


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
      super.createElement();
      element.appendChild(generateSVG(predefinedSVGElement()));
      //TODO deprecated using Heading2 quiet instead
      header = new PageTitle(); 
      header.element.classList.add(appendSelector("-heading"));
      header.element.classList.add("spectrum-heading");
      header.element.classList.add(header.typeNames);
      
      element.appendChild(header.element);
      //TODO change this to Body with a size of 4
      paragraph = new TextNode("p");
      paragraph.className = "spectrum-Body--secondary " + appendSelector("-description");
      element.appendChild(paragraph.element);

      return element;
    }

    private function ofTypeCTA():void //pg text needs HELP
    {
      header.text = "Drag and Drop Your File";
      paragraph.text = "" ; //problem 
      //TODO use Link
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