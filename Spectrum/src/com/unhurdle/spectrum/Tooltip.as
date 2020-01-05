package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconType;
  public class Tooltip extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/tooltip/dist.css">
     * </inject_html>
     * 
     */
    public function Tooltip()
    {
      super();
      //TODO add types and open/close
      // className = "spectrum-Tooltip--top";
      direction = "top";
    }
    override protected function getSelector():String{
      return "spectrum-Tooltip";
    }
    private var span1:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'span') as HTMLSpanElement;
      // direction = "top";
      span1 = new TextNode("");
      span1.element = newElement("span") as HTMLSpanElement;
      span1.className = appendSelector("-label");
      element.appendChild(span1.element);
      var span2:HTMLSpanElement;
      span2 = newElement("span") as HTMLSpanElement;
      span2.className = appendSelector("-tip");
      element.appendChild(span2);
      return element;
    }
    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
      span1.text = value;
    	_text = value;
    }
    private var _info:Boolean;

    private var _flavor:String;

    /**
     * The flavor of the Tooltip
     * One of info, positive and negative.
     * To set the Tooltip to the default, specify an empty string
     */
    public function get flavor():String
    {
    	return _flavor;
    }

    public function set flavor(value:String):void
    {
      if(value != _flavor){
        switch(value){
          case "info":
          case "positive":
          case "negative":
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
      }
    	_flavor = value;
    }


    private var iconElem:Icon;
    private var _icon:String;
    /**
     * Icon to display. One of: info, success, alert, help
     * Default is no value.
     */
    public function get icon():String
    {
    	return _icon;
    }

    public function set icon(value:String):void
    {
      var type:String;
      if(value == _icon){return;}
      if(!value){
        if(iconElem){
          iconElem.setStyle("display","none");
        }
        return;
      }
      switch(value){
        case "info":
          type = IconType.INFO_SMALL;
          break;
        case "success":
          type = IconType.SUCCESS_SMALL;
          break;
        case "alert":
          type = IconType.ALERT_SMALL;
          break;
        case "help":
          type = IconType.HELP_SMALL;
          break;
        default:
          throw new Error("unknown type: " + value);
      }
      var selector:String = Icon.getCSSTypeSelector(type);

      if(!iconElem){
        iconElem = new Icon(selector);
        iconElem.type = type;
        iconElem.className = appendSelector("-typeIcon");
        addElementAt(iconElem,0);
      } else {
        iconElem.selector = selector;
        iconElem.type = type;
        iconElem.setStyle("display",null);
      }
    	_icon = value;
    }
    private var _direction:String;

    public function get direction():String
    {
    	return _direction;
    }

    public function set direction(value:String):void
    {
      if(_direction){
        toggle(getSelector()+"--"+_direction,false);
      }
      if(value){
        switch(value){
          case "left":
          case "right":
          case "bottom":
          case "top":
            toggle(getSelector()+"--"+value,true);
            break;
          default:
            throw new Error("Invalid direction: " + value);
        }
      }
    	_direction = value;
    }
    private var _isOpen:Boolean;

    public function get isOpen():Boolean
    {
    	return _isOpen;
    }

    public function set isOpen(value:Boolean):void
    {
      if(value != !!_isOpen){
        toggle("is-open",value);
      }
    	_isOpen = value;
    }
  }
}
