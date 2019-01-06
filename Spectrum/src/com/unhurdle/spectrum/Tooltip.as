package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  public class Tooltip extends SpectrumBase
  {
    public function Tooltip()
    {
      super();
      typeNames = "spectrum-Tooltip spectrum-Tooltip--top is-open";
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
      span1.className = "spectrum-Tooltip-label";
      element.appendChild(span1.element);
      var span2:HTMLSpanElement;
      span2 = newElement("span") as HTMLSpanElement;
      span2.className = "spectrum-Tooltip-tip";
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
          var icon:Icon = new Icon("#spectrum-css-icon-InfoSmall");
          icon.className = "spectrum-Icon spectrum-UIIcon-InfoSmall spectrum-Tooltip-typeIcon";
          icon.selector = "#spectrum-css-icon-InfoSmall";
          element.appendChild(icon.getElement());
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
          var icon:Icon = new Icon("#spectrum-css-icon-SuccessSmall");
          icon.className = "spectrum-Icon spectrum-UIIcon-SuccessSmall spectrum-Tooltip-typeIcon";
          icon.selector = "#spectrum-css-icon-SuccessSmall";
          element.appendChild(icon.getElement());
        }
      }
    	_positiveIcon = value;
    }
  }
}
