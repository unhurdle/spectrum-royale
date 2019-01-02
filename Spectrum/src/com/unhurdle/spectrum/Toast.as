package com.unhurdle.spectrum
{
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
</div>
 * 
 */
  
  [Event(name="accept", type="org.apache.royale.events.Event")]

  public class Toast extends SpectrumBase
  {

    public static const INFO:String = "info";
    public static const NEGATIVE:String = "negative";
    public static const POSITIVE:String = "positive";
    public static const WARNING:String = "warning";

    public function Toast()
    {
      super();
      typeNames = "spectrum-Toast";
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

    private var _action:String;

    public function get action():String
    {
    	return _action;
    }

    public function set action(value:String):void
    {
    	_action = value;
    }

    private var _flavor:String;

    public function get flavor():String
    {
    	return _flavor;
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
          var oldFlavor:String = valueToCSS(_flavor);
          toggle(oldFlavor,false);
        }
        var newFlavor:String = valueToCSS(value);
        toggle(newFlavor,true);
      }
    	_flavor = value;
    }
    private function valueToCSS(value:String):String{
      return "spectrum-Toast--" + value;
    }

    private var icon:Icon;

    COMPILE::JS
    private function createIcon(status:String):void{
      var type:String;

      switch(status){
        case "negative":
          type = "Alert";
          break;
        case "positive":
          type = "Success";
          break;
        case "info":
          type = "Info";
          break;
        case "warning":
          type = "Alert";
          break;
      }
      if(!type){
        // no default icon
        return;
      }
      var iconClass:String = "spectrum-Icon spectrum-UIIcon-" + type + "Medium spectrum-Toast-typeIcon";
      var useSelector:String = '#spectrum-css-icon-' + type + 'Medium';
      if(icon){
        icon.className = iconClass;
        icon.selector = useSelector;
      } else {
        icon = new Icon(useSelector);
        icon.className = iconClass;
        element.insertBefore(icon.getElement(), element.childNodes[0] || null);
      }

    }

  }
}