package com.unhurdle.spectrum
{
  import org.apache.royale.utils.Timer;
  import org.apache.royale.events.Event;
  import org.apache.royale.utils.css.addDynamicSelector;
  import com.unhurdle.spectrum.Button;
  
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }
  
  [Event(name="accept", type="org.apache.royale.events.Event")]
  [Event(name="close", type="org.apache.royale.events.Event")]
  
  public class Toast extends SpectrumBase implements ITextContent
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/toast/dist.css">
     * </inject_html>
     * 
     */
    // flag to set the keyframes on  the first instantiation

    public function Toast(content:String = null,autoClose:int=0)
    {
      super();
      typeNames = appendSelector("-container");
      if(content){
        text = content;
      }
      this.autoClose = autoClose;
      if(!keyFramesSet){
        setKeyFrames()
      }
    }
    private static var keyFramesSet:Boolean;

    public static const INFO:String = "info";
    public static const NEGATIVE:String = "negative";
    public static const POSITIVE:String = "positive";
    public static const WARNING:String = "warning";
    public static const SUCCESS:String = "success";

    override protected function getSelector():String{
      return "spectrum-Toast";
    }

    protected function setKeyFrames():void{
      // only do this once
      keyFramesSet = true;

      var selector:String = "@-webkit-keyframes spectrum-toast-fadein";
      var rule:String = "from {bottom: 0; opacity: 0;} to {bottom: 30px; opacity: 1;}";
      addDynamicSelector(selector, rule);
      selector = "@keyframes spectrum-toast-fadein";
      addDynamicSelector(selector, rule);
      selector = "@-webkit-keyframes spectrum-toast-fadeout";
      rule = "from {bottom: 30px; opacity: 1;} to {bottom: 0px; opacity: 0;}";
      addDynamicSelector(selector, rule);
      selector = "@keyframes spectrum-toast-fadeout";
      addDynamicSelector(selector, rule);
      selector = ".spectrum-Toast-container.show";
      rule = "visibility: visible; -webkit-animation: spectrum-toast-fadein 0.5s; animation: spectrum-toast-fadein 0.5s;";
      addDynamicSelector(selector, rule);
      selector = ".spectrum-Toast-container.hide";
      rule = "visibility: visible; -webkit-animation: spectrum-toast-fadeout 0.5s; animation: spectrum-toast-fadeout 0.5s;";
      addDynamicSelector(selector, rule);

    }

    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      contentNode.text = value;
    }

    private var _action:String;

    public function get action():String
    {
    	return _action;
    }

    private var actionButton:Button;
    
    public function set action(value:String):void
    {
      if(!actionButton){
        actionButton = new Button();
        actionButton.flavor = Button.OVER_BACKGROUND;
        actionButton.quiet = true;
        actionButton.addEventListener("click",onAction);
        body.appendChild((actionButton.element as HTMLElement));
      }
      actionButton.text = value;
    	_action = value;
    }
    protected function onAction(ev:Event):void{
      if(_shown){
        dispatchEvent(new Event("accept"));
      }
      hide();
    }

    private var _flavor:String;

    public function get flavor():String
    {
    	return _flavor;
    }

    private var timer:Timer;
    public function show():void{
      if(_shown){
        return;
      }
      _shown = true;
      Application.current.popUpParent.addElement(this);
      toggle("show",true);
      COMPILE::JS
      {
        element.style.visibility = null;
      }
      if(autoClose){
        timer = new Timer(autoClose);
        timer.addEventListener(Timer.TIMER,onTimer)
        timer.start();
      }
    }

    private function onTimer(ev:Event):void{
      timer.removeEventListener(Timer.TIMER,onTimer);
      hide();
    }
    private var _shown:Boolean;
    public function hide():void{
      if(!_shown){
        return;
      }
      _shown = false;
      toggle("show", false);
      toggle("hide",true);
      setTimeout(removeMe,500);
      dispatchEvent(new Event("close"));
    }

    private function removeMe():void{
        Application.current.popUpParent.removeElement(this);
        toggle("hide", false);
    }

    private var _autoClose:int = 0;

    /**
     * Number of milliseconds the Toast will remain open.
     * A value of 0 (default) will cause it to remain open until closed.
     */
    public function get autoClose():int
    {
    	return _autoClose;
    }

    public function set autoClose(value:int):void
    {
    	_autoClose = value;
    }

    [Inspectable(category="General", enumeration="info,success,positive,negative,warning")]
    /**
     * Set the flavor of the Toast
     * One of info, success, positive and negative. warning also appears to be an option
     * To set the Toast to the default, specify an empty string
     */
    public function set flavor(value:String):void
    {
      if(value != _flavor){
        switch(value){
          case "info":
          case "positive":
          case "success":
          case "negative":
          case "error":
          case "warning":
          case "":
            break;
          default:
            throw new Error("Unknown flavor: " + value);
        }
        if(_flavor){
          var oldFlavor:String = valueToSelector(_flavor);
          toast.classList.remove(oldFlavor);
        }
        var newFlavor:String = valueToSelector(value);
          toast.classList.add(newFlavor);
          createIcon(value);
      }
    	_flavor = value;
    }

    private var icon:Icon;
    
    private function createIcon(flavor:String):void{
      var type:String;

      switch(flavor){
        case "negative":type = "Alert";break;
        case "positive":type = "Success";break;
        case "success":type = "Success";break;
        case "info":type = "Info";break;
        case "error":type = "Alert";break;
        case "warning":type = "Alert";break;
        default: return; // no default icon
      }
      var sizedType:String = type + "Medium";
      var iconClass:String = appendSelector("-typeIcon");
      var useSelector:String = Icon.getCSSTypeSelector(sizedType);
      if(icon){
        icon.type = sizedType;
        icon.toggle(iconClass,true);
        icon.selector = useSelector;
      } else {
        icon = new Icon(useSelector);
        icon.type = sizedType;
        icon.toggle(iconClass,true);
        COMPILE::JS{
          toast.insertBefore(icon.element ,body || null);
        }
      }

    }
    private var toast:HTMLElement;
    private var contentNode:TextNode;
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      var styleStr:String = "visibility:hidden;position:fixed;bottom:30px;width:100%;display:flex;align-items:center;justify-content:center;z-index:100;";
      elem.setAttribute("style",styleStr);
      toast = newElement("div");
      toast.className = getSelector();
      body = newElement("div");
      body.className = appendSelector("-body");
      contentNode = new TextNode("div");
      contentNode.className = appendSelector("-content");
      body.appendChild(contentNode.element);
      toast.appendChild(body);

      var buttons:HTMLElement = newElement("div");
      buttons.className = appendSelector("-buttons");

      var button:ClearButton = new ClearButton();
      button.overBackground = true;
      buttons.appendChild(button.element);
      button.addEventListener("click",hide);
      toast.appendChild(buttons);

      elem.appendChild(toast);

      return elem;
    }

    protected var body:HTMLElement;

  }
}