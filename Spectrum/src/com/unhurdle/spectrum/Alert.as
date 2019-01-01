package com.unhurdle.spectrum
{

    COMPILE::JS {
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    
    COMPILE::SWF
    public class Alert extends SpectrumBase{
        public var text:String;
    }
    COMPILE::JS
    public class Alert extends SpectrumBase
    
    {
//     <div class="spectrum-Alert spectrum-Alert--error"> -- closable --
//   <svg class="spectrum-Icon spectrum-UIIcon-AlertMedium spectrum-Alert-icon" focusable="false" aria-hidden="true"> --
//     <use xlink:href="#spectrum-css-icon-AlertMedium" /> --
//   </svg>
//   <div class="spectrum-Alert-header">Incorrect Payment Information - Error</div> --
//   <div class="spectrum-Alert-content">This is an alert.</div>
//   <div class="spectrum-Alert-footer">
//     <button class="spectrum-Button spectrum-Button--primary spectrum-Button--quiet">Close</button>
//   </div>
// </div>
       public function Alert()
       {
        super();
        typeNames = "spectrum-Alert ";  
       }

        private var header:HTMLDivElement;
        private var footer:HTMLDivElement;
        private var content:HTMLDivElement;
        private var button:HTMLButtonElement; //use the spectrum button? //eventually
        private var icon:SVGElement;
        private var useElement:SVGUseElement;
        private function createIcon(type:String):void{
            icon = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            icon.className = "spectrum-Icon spectrum-UIIcon-" + type + "Medium spectrum-Alert-icon";
            useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
            useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-' + type + 'Medium');
            icon.appendChild(useElement);
            element.insertBefore(icon, element.childNodes[0] || null);
        }
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            icon = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement; 
            icon.setAttribute("focusable",false);
            var useElement:WrappedHTMLElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as WrappedHTMLElement;
            header = newElement('div') as HTMLDivElement;
            header.className = "spectrum-Alert-header";
            elem.appendChild(header);
            content =newElement('div') as HTMLDivElement;
            content.className = "spectrum-Alert-content";
            content.appendChild(button);
            elem.appendChild(content);
            var type:String;
            switch(status){
            case Alert.CLOSABLE: 
                type = "Alert";
                footer = newElement('div') as HTMLDivElement;
                footer.className = "spectrum-Alert-footer";
                button = newElement("button") as HTMLButtonElement;
                button.className = "spectrum-Button spectrum-Button--primary spectrum-Button--quiet";
                footer.appendChild(button);
                elem.appendChild(footer);
                break;   
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
            createIcon(type);
            elem.appendChild(icon);
            return elem;
        }
        
        COMPILE::JS
        public function showAlert(parent:Object) : void
		{
			parent.addElement(this);
		}
        
        COMPILE::JS
        static public function show(message:String, parent:Object):Alert
		{
            // var alert:Alert = new Alert();
            // alert.message = message;
            // alert.showAlert(parent);                    
            // return alert;
            return null;
        
        }
       private var _text:String;

        public function get text():String
        {
        	return _text;
        }

        public function set text(value:String):void
        {
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
        	_status = value;
        }
        // if(!icon){
        //     icon = getIcon();
        //     var firstElem:Node = elem.childNodes[0];
        //     // var firstElem:Node = element.childNodes[0];
        //     if(firstElement){
        //         elem.insert
        //         // element.insert
        //     }
        //     if(element.)
        // }
        }
    COMPILE::JS
    private function valueToCSS(status:String):String{
      return "spectrum-Alert--" + status;
    }

   
    }
}
