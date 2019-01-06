package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  public class Switch extends SpectrumBase
  {
    public function Switch()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-ToggleSwitch";
    }
    private var label:TextNode;
    COMPILE::JS
    private var input:HTMLInputElement;
    COMPILE::SWF
    private var input:Object;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      input = newElement("input") as HTMLInputElement;
      input.className = getSelector() + "-input";
      input.type = "checkbox";
      elem.appendChild(input);
      var span:HTMLElement = newElement("span");
      span.className = getSelector() + "-switch";
      elem.appendChild(span);
      label = new TextNode("label");
      label.className = getSelector() + "-label";
      elem.appendChild(label.element);
      return elem;
    }
    private var _text:String;
    public function get text():String
    {
      return _text;
    }

    public function set text(value:String):void
    {
      _text = value
      label.text = value;
    }
    private var _checked:Boolean;

    public function get checked():Boolean
    {
    	return _checked;
    }

    public function set checked(value:Boolean):void
    {
      if(value != !!_checked){
        input.checked = value;
      }
    	_checked = value;
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        input.disabled = value;
      }
    	_disabled = value;
    }
    private var _onOff:Boolean = true;

    public function get onOff():Boolean
    {
    	return _onOff;
    }

    public function set onOff(value:Boolean):void
    {
      if(!!value != _onOff){
        toggle(valueToSelector("ab"),!value);
      	_onOff = value;
      }
    }
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
          toggle(valueToSelector("quiet"),value);
      }
    	_quiet = value;
    }
  }
}