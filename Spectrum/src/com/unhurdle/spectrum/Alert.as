package com.unhurdle.spectrum
{

  COMPILE::JS {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  
  public class Alert extends SpectrumBase
  
  {
//   <div class="spectrum-Alert spectrum-Alert--error"> -- closable --
//   <svg class="spectrum-Icon spectrum-UIIcon-AlertMedium spectrum-Alert-icon" focusable="false" aria-hidden="true"> --
//   <use xlink:href="#spectrum-css-icon-AlertMedium" /> --
//   </svg>
//   <div class="spectrum-Alert-header">Incorrect Payment Information - Error</div> --
//   <div class="spectrum-Alert-content">This is an alert.</div>
//   <div class="spectrum-Alert-footer">
//   <button class="spectrum-Button spectrum-Button--primary spectrum-Button--quiet">Close</button>
//   </div>
// </div>
    public function Alert(){
      super();
      typeNames = "spectrum-Alert";  
    }

    private var _closeText:String;

    public function get closeText():String{
      return _closeText;
    }

    public function set closeText(value:String):void{
      if(value != _closeText){
        setCloseButton(value);
      }
      _closeText = value;
    }

    private var button:HTMLButtonElement; //use the spectrum button? //eventually
    private var icon:SVGElement;
    private var useElement:SVGUseElement;
    
    COMPILE::JS
    private function createIcon(status:String):void{
      var type:String;

      switch(status){
        case Alert.ERROR:
          type = "Alert";
          break;
        case Alert.HELP:
          type = "Help";
          break;
        case Alert.INFO:
          type = "Info";
          break;
        case Alert.SUCCESS:
          type = "Success";
          break;
        case Alert.WARNING:
          type = "Alert";
          break;
      }
      if(!type){
        type == "Alert";
      }

      if(icon){
        icon.className = "spectrum-Icon spectrum-UIIcon-" + type + "Medium spectrum-Alert-icon";
        useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-' + type + 'Medium');
      } else {
        icon = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
        icon.className = "spectrum-Icon spectrum-UIIcon-" + type + "Medium spectrum-Alert-icon";
        useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
        useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-' + type + 'Medium');
        icon.appendChild(useElement);
        element.insertBefore(icon, element.childNodes[0] || null);
      }

    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      icon = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement; 
      icon.setAttribute("focusable",false);
      useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
      var header:HTMLElement = newElement('div');
      header.className = "spectrum-Alert-header";
      elem.appendChild(header);
      var content:HTMLElement = newElement('div');
      content.className = "spectrum-Alert-content";
      content.appendChild(button);
      elem.appendChild(content);

      if(_closeText){

      }
      return elem;
    }

    COMPILE::JS
    private var closeButtonNode:Text;

    COMPILE::SWF
    private var closeButtonNode:Object;

    private function setCloseButton(value:String):void{
      COMPILE::JS
      {
        if(!closeButtonNode){
          var footer:HTMLElement = newElement('div');
          footer.className = "spectrum-Alert-footer";
          button = newElement("button") as HTMLButtonElement;
          button.className = "spectrum-Button spectrum-Button--primary spectrum-Button--quiet";
          closeButtonNode = newTextNode(value);
          button.appendChild(closeButtonNode);
          footer.appendChild(button);
          element.appendChild(footer);
        } else {
          closeButtonNode.nodeValue = value;
        }
      }

    }
    
    COMPILE::JS
    public function showAlert(parent:Object):void{
			parent.addElement(this);
		}
    
    private var _text:String;

    public function get text():String{
    	return _text;
    }

    public function set text(value:String):void{
    	_text = value;
    }

     
    public static const CLOSABLE:String = "error";
    public static const ERROR:String = "error";
    public static const HELP:String = "help";
    public static const INFO:String = "info";
    public static const SUCCESS:String = "success";
    public static const WARNING:String = "warning";
    
    
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
            case Alert.CLOSABLE:
            case Alert.ERROR:
            case Alert.HELP:
            case Alert.INFO:
            case Alert.SUCCESS:
            case Alert.WARNING:
              break;
            default:
              throw new Error("Invalid status: " + value);
          }
          var oldStatus:String = valueToCSS(_status);
          var newStatus:String = valueToCSS(value);
          toggle(newStatus, true);
          toggle(oldStatus, false);
          createIcon(value);
        }
      }
      _status = value;
    }
    COMPILE::JS
    private function valueToCSS(status:String):String{
      return "spectrum-Alert--" + status;
    }   
  }
}
