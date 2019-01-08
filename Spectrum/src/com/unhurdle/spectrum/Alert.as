package com.unhurdle.spectrum
{

  import org.apache.royale.html.beads.plugin.ModalDisplay;
  import org.apache.royale.html.beads.plugin.ModalOverlay;
  import org.apache.royale.utils.CSSUtils;

  COMPILE::JS {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import com.unhurdle.spectrum.Icon;
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
      visible = false;
      modal = new ModalDisplay();
      addBead(modal);
    }
    override protected function getSelector():String{
      return "spectrum-Alert";
    }

    private var _overlayColor:String;

    /**
     * The color value of the overlay (default black)
     * Either overlayColor or overlayAlpha needs to be set for an overlay to show at all.
     * 
     */
    public function get overlayColor():String
    {
    	return _overlayColor;
    }

    public function set overlayColor(value:String):void
    {
    	_overlayColor = value;
      getOverlayBead().color = CSSUtils.toColor(value);
    }
    private var _overlayAlpha:Number;

    /**
     * The alpha of the overlay in a value of 0 through 1 (default 0.5).
     * Either overlayColor or overlayAlpha needs to be set for an overlay to show at all.
     * 
     */
    public function get overlayAlpha():Number
    {
    	return _overlayAlpha;
    }

    public function set overlayAlpha(value:Number):void
    {
    	_overlayAlpha = value;
      getOverlayBead().alpha = value;
    }

    private var modal:ModalDisplay;
    
    private function getOverlayBead():ModalOverlay{
      if(!_overlayBead){
        _overlayBead = new ModalOverlay();
        addBead(_overlayBead);
      }
      return _overlayBead
    }
    private var _overlayBead:ModalOverlay;

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

    private var _header:String;

    public function get header():String
    {
      return _header;
    }

    public function set header(value:String):void
    {
      headerNode.text = value;
      _header = value;
    }

    private var _content:String;

    public function get content():String
    {
      return _content;
    }

    public function set content(value:String):void
    {
      contentNode.text = value;
      _content = value;
    }

    private var headerNode:TextNode;

    private var contentNode:TextNode;

    private var button:Button;
    
    private var icon:Icon;
    
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
      var sizedType:String = type + "Medium";
      var iconClass:String = appendSelector("-icon");
      var selector:String = Icon.getCSSTypeSelector(sizedType);
      if(icon){
        icon.type = sizedType;
        icon.className = iconClass;
        icon.selector = selector;
      } else {
        icon = new Icon(selector);
        icon.type = sizedType;
        icon.className = iconClass;
        element.insertBefore(icon.element, element.childNodes[0] || null);
        icon.addedToParent();
      }

    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var styleStr:String = "z-index:100;";
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      elem.setAttribute("style",styleStr);
      headerNode = new TextNode("div");
      headerNode.className = appendSelector("-header");
      elem.appendChild(headerNode.element);

      contentNode = new TextNode("div");
      contentNode.className = appendSelector("-content");
      elem.appendChild(contentNode.element);

      return elem;
    }
    
    private function setCloseButton(value:String):void{
      COMPILE::JS
      {
        if(!button){
          var footer:HTMLElement = newElement('div');
          footer.className = appendSelector("-footer");
          button = new Button();
          button.quiet = true;
          button.element.onclick = hide;
          footer.appendChild(button.element);
          element.appendChild(footer);
        }
        button.text = value;
      }

    }
    
    public function show():void{
      visible = true;
      modal.show(Application.current);
		}

    public function hide():void{
      modal.hide();
    }
    
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
      //TODO can status be none?
      COMPILE::JS
      {
        if(value != _status){
          switch(value){
            case Alert.ERROR:
            case Alert.HELP:
            case Alert.INFO:
            case Alert.SUCCESS:
            case Alert.WARNING:
              break;
            default:
              throw new Error("Invalid status: " + value);
          }
          if(_status){
            toggle(valueToSelector(_status), false);
          }
          toggle(valueToSelector(value), true);
          createIcon(value);
        }
      }
      _status = value;
    }
  }
}
