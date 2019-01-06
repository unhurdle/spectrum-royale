package com.unhurdle.spectrum
{
  import org.apache.royale.utils.Timer;
  import org.apache.royale.events.Event;
  import org.apache.royale.utils.css.addDynamicSelector;
  import com.unhurdle.spectrum.Button;
  
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  
  [Event(name="accept", type="org.apache.royale.events.Event")]

  [Event(name="close", type="org.apache.royale.events.Event")]
  
  public class Toast extends SpectrumBase
  {
    // flag to set the keyframes on  the first instantiation
    private static var keyFramesSet:Boolean;

    public static const INFO:String = "info";
    public static const NEGATIVE:String = "negative";
    public static const POSITIVE:String = "positive";
    public static const WARNING:String = "warning";

    public function Toast(content:String = null)
    {
      super();
      typeNames = getSelector() + "-container";
      if(content){
        text = content;
      }
      if(!keyFramesSet){
        setKeyFrames()
      }
    }
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
        COMPILE::JS
        {
          body.appendChild(actionButton.element);
        }
      }
      actionButton.text = value;
    	_action = value;
    }
    private function onAction(ev:Event):void{
      dispatchEvent(new Event("accept"));
      hide();
    }

    private var _flavor:String;

    public function get flavor():String
    {
    	return _flavor;
    }

    private var timer:Timer;
    public function show():void{
      Application.current.addElement(this);
      toggle("show",true);
      COMPILE::JS
      {
        element.style.visibility = null;
      }
      if(autoClose){
        var timer:Timer = new Timer(autoClose);
        timer.addEventListener(Timer.TIMER,onTimer)
      }
    }

    private function onTimer(ev:Event):void{
      timer.removeEventListener(Timer.TIMER,onTimer);
      hide();
    }

    public function hide():void{
      toggle("show", false);
      toggle("hide",true);
      COMPILE::JS
      {
        setTimeout(removeMe,500);
      }
        dispatchEvent(new Event("close"));
    }

    private function removeMe():void{
        Application.current.removeElement(this);
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

    /**
     * Set the flavor of the Toast
     * One of info, positive and negative. warning also appears to be an option
     * To set the Toast to the default, specify an empty string
     */
    public function set flavor(value:String):void
    {
      if(value != _flavor){
        switch(value){
          case "info":
          case "positive":
          case "negative":
          case "warning":
          case "":
            break;
          default:
            throw new Error("Unknown flavor: " + value);
        }
        if(_flavor){
          var oldFlavor:String = valueToSelector(_flavor);
          toggle(oldFlavor,false);
        }
        var newFlavor:String = valueToSelector(value);
        toggle(newFlavor,true);
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
        case "info":type = "Info";break;
        case "warning":type = "Alert";break;
        default: return; // no default icon
      }
      var iconClass:String = "spectrum-Icon spectrum-UIIcon-" + type + "Medium spectrum-Toast-typeIcon";
      var useSelector:String = '#spectrum-css-icon-' + type + 'Medium';
      if(icon){
        icon.className = iconClass;
        icon.selector = useSelector;
      } else {
        icon = new Icon(useSelector);
        icon.className = iconClass;
        COMPILE::JS
        {
          element.insertBefore(icon.getElement(), element.childNodes[0] || null);
        }
      }

    }
    private var contentNode:TextNode;
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var styleStr:String = "visibility:hidden;position:absolute;bottom:30px;width:100%;display:flex;align-items:center;justify-content:center;";
      var elem:WrappedHTMLElement = addElementToWrapper(this,"div");
      elem.setAttribute("style",styleStr);
      var toast:HTMLElement = newElement("div");
      toast.className = "spectrum-Toast";
      body = newElement("div");
      body.className = "spectrum-Toast-body";
      contentNode = new TextNode("div");
      contentNode.className = "spectrum-Toast-content";
      body.appendChild(contentNode.element);
      toast.appendChild(body);

      var buttons:HTMLElement = newElement("div");
      buttons.className = "spectrum-Toast-buttons";

      var button:ClearButton = new ClearButton();
      button.overBackground = true;
      buttons.appendChild(button.element);
      button.addEventListener("click",hide);
      toast.appendChild(buttons);

      elem.appendChild(toast);

      return elem;
    }

    COMPILE::JS
    private var body:HTMLElement;
    /**
<div class="spectrum-Toast spectrum-Toast--info">
  <svg class="spectrum-Icon spectrum-UIIcon-InfoMedium spectrum-Toast-typeIcon" focusable="false" aria-hidden="true">
    <use xlink:href="#spectrum-css-icon-InfoMedium"></use>
  </svg>
  <div class="spectrum-Toast-body">
    <div class="spectrum-Toast-content">
      A new version of Lightroom Classic is now available
    </div>
    <button class="spectrum-Button spectrum-Button--overBackground spectrum-Button--quiet">
      <span class="spectrum-Button-label">Update</span>
    </button>
  </div>
  <div class="spectrum-Toast-buttons">
    <button class="spectrum-ClearButton spectrum-ClearButton--medium spectrum-ClearButton--overBackground">
      <svg class="spectrum-Icon spectrum-UIIcon-CrossMedium focusable=" false"="" aria-hidden="true">
        <use xlink:href="#spectrum-css-icon-CrossMedium"></use>
      </svg>
    </button>
  </div>

     */
  }
}