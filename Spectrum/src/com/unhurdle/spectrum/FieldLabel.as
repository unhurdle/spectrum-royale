package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.includes.FieldLabelInclude;

  public class FieldLabel extends TextBase
  {
    public function FieldLabel()
    {
      super();
      focusable = false;
    }
    override protected function getSelector():String{
      return FieldLabelInclude.getSelector();
    }

    public static const TOP:String = "top";
    public static const LEFT:String = "left";
    public static const RIGHT:String = "right";

    private var _for:String;

    public function get for():String
    {
    	return _for;
    }

    public function set for(value:String):void
    {
      if(value != _for){
        if(value){
          setAttribute("for",value);
        } else {
          removeAttribute("for");
        }
        _for = value;
      }
    }

    public function get tabDisabled():Boolean{
    	return true;
    }

    private var requiredIcon:Icon;
    private var _required:Boolean;

    public function get required():Boolean
    {
    	return _required;
    }

    public function set required(value:Boolean):void
    {
      if(value == !!_required){
        return;
      }
      if(value && !requiredIcon){
        COMPILE::JS{
          if(!textNode){
            createTextNode();
          }
        }
        var type:String = IconType.ASTERISK;
        requiredIcon = new Icon(Icon.getCSSTypeSelector(type));
        requiredIcon.type = type;
        requiredIcon.className = appendSelector("-requiredIcon");
        addElement(requiredIcon);
      } else if(requiredIcon){
        requiredIcon.visible = value;
      }
    	_required = value;
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        toggle("is-disabled",value);
        _disabled = value;
      }
    }
    private var _position:String;

    /**
     * position can be top (default), left or right
     */
    public function get position():String
    {
    	return _position;
    }

    [Inspectable(category="General", enumeration="top,left,right", defaultValue="top")]
    public function set position(value:String):void
    {
      if(value == _position){
        return;
      }
      if(_position){
        toggle(valueToSelector(_position),false);
      }
      if(value == "top" || !value){
        return;
      }
      switch(value)
      {
        case "left":
        case "right":
          break;
        default:
          throw new Error("invalid position: " + value);
      }
      toggle(valueToSelector(value),true);
    	_position = value;
    }

    override protected function getTag():String{
      return "label";
    }

    override public function set focusable(value:Boolean):void{
      super.focusable = value;
      if(!value){
        style = {"user-select":"none"};
      }
    }
  }
}