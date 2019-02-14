package com.unhurdle.spectrum
{//simpleFileUploader
  //target = _blank -- new tab in browser for hyperlink
  //draggable html drag n drop
  COMPILE::JS{
  import org.apache.royale.html.util.addElementToWrapper;
  import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.Icon;
  import com.unhurdle.spectrum.IllustratedMessage;
  
  import org.apache.royale.file.beads.FileModel;
  import org.apache.royale.file.beads.FileLoader;
  import org.apache.royale.file.beads.FileBrowser;
  import org.apache.royale.events.ValueEvent;

  import org.apache.royale.html.SimpleAlert;
  import org.apache.royale.file.FileProxy;
  import org.apache.royale.events.Event;
  import org.apache.royale.textLayout.edit.ElementRange;
  
  
	[Event(name="filesAvailable", type="org.apache.royale.events.ValueEvent")]

  public class DropZone extends SpectrumBase 
  { 
    private var browser:FileBrowser;
    private var loader:FileLoader;
    private var fileProxy:FileProxy;
   
    public function DropZone(){
      super();
      fileProxy = new FileProxy();
      browser = new FileBrowser();
      loader = new FileLoader();
      fileProxy.addBead(loader);  
      fileProxy.addBead(browser); 
    }

    override protected function getSelector():String{
      return "spectrum-Dropzone";
    }

    private function elementDragged(ev:Event):void{
      ev.preventDefault();
      toggle("is-dragged",true);
    }

    private function elementNotDragged(ev:Event):void{
      toggle("is-dragged",false);
    }

    private function dropped(ev:DragEvent):void{  
      ev.preventDefault();
      toggle("is-dragged",false);
      var fileList:FileList = ev.dataTransfer.files;
      dispatchEvent(new ValueEvent("filesAvailable",fileList));
    }

    COMPILE::JS
    private function uploadFile():void{
      fileProxy.addEventListener("modelChanged",modelChangedHandler);
      browser.browse();
    }

    COMPILE::JS
    protected function modelChangedHandler(event:Event):void
		{
        dispatchEvent(new ValueEvent("filesAvailable",[(fileProxy.model as FileModel).file]));
		}
  
  COMPILE::JS
  override protected function createElement():WrappedHTMLElement{
    addElementToWrapper(this,'div');
    element.setAttribute("role","region"); 
    element.tabIndex = 0;
    element.style.width = "300px";
    element.addEventListener('dragenter', elementDragged);
    element.addEventListener('dragleave', elementNotDragged); 
    element.addEventListener('dragover', elementDragged);
    element.addEventListener('drop', dropped);
    
    var illustratedMessage:IllustratedMessage = new IllustratedMessage();
    illustratedMessage.type = "cta";
    illustratedMessage.hyperlink.element.addEventListener('click',uploadFile)
    element.appendChild(illustratedMessage.element);

    // var illustratedMessage:HTMLElement = newElement('div');
    // illustratedMessage.className = "spectrum-IllustratedMessage spectrum-IllustratedMessage--cta";

 
    // illustratedMessage.appendChild(generateSVG(predefinedSVGElement()));
    // element.appendChild(illustratedMessage);

    // var header:TextNode = new TextNode("h2");
    // header.className = "spectrum-Heading spectrum-Heading--pageTitle spectrum-IllustratedMessage-heading";
    // header.text = "Drag and Drop Your File";
    // element.appendChild(header.element);

    // var paragraph:TextNode = new TextNode("p");
    // paragraph.className = "spectrum-Body--secondary spectrum-IllustratedMessage-description";
    // element.appendChild(paragraph.element);

    // paragraph.text = "or ";  //in the wrong spot

    // var hyperlink:TextNode = new TextNode("a");
    // (hyperlink as HTMLLinkElement).href ="#"; 
    // hyperlink.className = "spectrum-Link";
    // hyperlink.text = "Select a File"; 
    // hyperlink.element.addEventListener('click',uploadFile); 

    // paragraph.element.appendChild(hyperlink.element);
    // paragraph.text = "from your computer ";  //not displaying
    
    // var br:HTMLElement = newElement("br");
    // paragraph.element.appendChild(br);
    return element;
    }
  
  
  }
}