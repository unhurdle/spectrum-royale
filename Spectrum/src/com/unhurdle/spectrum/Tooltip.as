package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    import com.unhurdle.spectrum.const.IconType;
    import com.unhurdle.spectrum.const.IconType;
  }
  public class Tooltip extends SpectrumBase
  {
    public function Tooltip()
    {
      super();
      //TODO add types and open/close
      className = "spectrum-Tooltip--top is-open";
    }
    override protected function getSelector():String{
      return "spectrum-Tooltip";
    }
    private var span1:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'span') as HTMLSpanElement;
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

    public function get info():Boolean
    {
    	return _info;
    }

    public function set info(value:Boolean):void
    {
      if(value != _info){
        toggle(valueToSelector("info"),value);
      }
    	_info = value;
    }
    private var _infoIcon:Boolean;

    public function get infoIcon():Boolean
    {
    	return _infoIcon;
    }

    public function set infoIcon(value:Boolean):void
    {
      COMPILE::JS{
        if(value != !!_infoIcon && value){
          var type:String = IconType.INFO_SMALL;
          var icon:Icon = new Icon(Icon.getCSSTypeSelector(type));
          icon.type = type;
          icon.className = appendSelector("-typeIcon");
          element.insertBefore(icon.element,( element.childNodes[0] || null));
          icon.addedToParent();
        }
      }
    	_infoIcon = value;
    }

    private var _positive:Boolean;

    public function get positive():Boolean
    {
    	return _positive;
    }

    public function set positive(value:Boolean):void
    {
      if(value != _positive){
        toggle(valueToSelector("positive"),value);
      }
    	_positive = value;
    }
    private var _positiveIcon:Boolean;

    public function get positiveIcon():Boolean
    {
    	return _positiveIcon;
    }

    public function set positiveIcon(value:Boolean):void
    {
      COMPILE::JS{
        if(value != !!_positiveIcon && value){
          var type:String = IconType.SUCCESS_SMALL;
          var icon:Icon = new Icon(Icon.getCSSTypeSelector(type));
          icon.type = type;
          icon.className = appendSelector("-typeIcon");
          element.insertBefore(icon.element,( element.childNodes[0] || null));
          icon.addedToParent();
        }
      }
    	_positiveIcon = value;
    }
  }
}
