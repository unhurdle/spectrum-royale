package com.unhurdle.spectrum
{
  COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        // import org.apache.royale.html.elements.Img;
    }
  public class DialogPopover extends Popover
  {
    public function DialogPopover()
    {
      super();
      toggle(valueToSelector("dialog"),true);
    }
    // override protected function getSelector():String{
    //     // return super() + "--dialog";
    //     return appendSelector("--dialog");
    // }
 
  //   private function createDialog():void
  //   {
  // //     <div class="spectrum-Dialog-header">
  // //   <div class="spectrum-Dialog-title">Popover Title</div>
  // // </div>
  // // <div class="spectrum-Dialog-content">Cupcake ipsum dolor sit amet jelly beans. Chocolate jelly caramels. Icing soufflé chupa chups donut cheesecake. Jelly-o chocolate cake sweet roll cake danish candy biscuit halvah</div>
  // // <div class="spectrum-Popover-tip"></div>
  //   }
    private var header:DialogHeader;
    private var title:TextNode;
    private var content:TextNode;    
    private var footer:DialogFooter;
    private var tip:HTMLDivElement;
    private var icon:HTMLDivElement;

    // private var step:TextNode;
    // private var imageElement:HTMLImageElement;
    // private var nextButton:Button;
    // private var skipTourButton:Button;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        header = new DialogHeader();
        title = new TextNode("");
        title.element = newElement("div","spectrum-Dialog-title") as HTMLDivElement;
        header.element.appendChild(title.element);
        elem.appendChild(header.element);
        content = new TextNode("");
        content.element = newElement("div","spectrum-Dialog-content") as HTMLDivElement;
        // content.element = new DialogContent() as HTMLElement;
        elem.appendChild(content.element);
        tip = newElement("div","spectrum-Popover-tip") as HTMLDivElement;
        elem.appendChild(tip);
        return elem;
    }    
        private var _titleText:String;
        public function get titleText():String
        {
        	return _titleText;
        }
        public function set titleText(value:String):void
        {
        	_titleText = value;
          title.text = value;
        }
        private var _contentText:String;
        public function get contentText():String
        {
        	return _contentText;
        }
        public function set contentText(value:String):void
        {
        	_contentText = value;
          content.text = value;
        }
        private var _status:String;

        public function get status():String
        {
        	return _status;
        }

        public function set status(value:String):void
        {
          //TODO can status be none?
          if(value != _status){
            switch(value){
              case "":
              case "error":
              case "success":
                break;
              default:
                throw new Error("Invalid status: " + value);
            }
            COMPILE::JS{
              if(_status){
                toggle("spectrum-Dialog--" + _status, false);
                if(header.element.contains(icon)){
                  header.element.removeChild(icon);
                }
                if(element.contains(footer.element)){
                  element.removeChild(footer.element);
                }
              }            
              if(value){
                toggle("spectrum-Dialog--" + value, true);
                icon = newElement("div","spectrum-Dialog-typeIcon") as HTMLDivElement;
                header.element.appendChild(icon);
                footer = new DialogFooter();
                var cancelButton:Button = new Button();
                cancelButton.text = "cancel";
                cancelButton.quiet = true;
                cancelButton.flavor = "secondary"; 
                footer.addElement(cancelButton);
                var saveButton:Button = new Button();
                saveButton.text = "save";
                saveButton.quiet = true;
                saveButton.flavor = "primary"; 
                footer.addElement(saveButton);
                element.appendChild(footer.element);
              }
            }
          }
          _status = value;
        }
  }
}