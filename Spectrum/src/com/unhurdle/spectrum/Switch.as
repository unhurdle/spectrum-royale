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
      typeNames = "spectrum-ToggleSwitch";
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
      input.className = "spectrum-ToggleSwitch-input";
      input.type = "checkbox";
      elem.appendChild(input);
      var span:HTMLSpanElement = newElement("span") as HTMLSpanElement;
      span.className = "spectrum-ToggleSwitch-switch";
      elem.appendChild(span);
      label = new TextNode("");
      label.element = newElement("label") as HTMLLabelElement;
      label.className = "spectrum-ToggleSwitch-label";
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
    private var _blue:Boolean;

    public function get blue():Boolean
    {
    	return _blue;
    }

    public function set blue(value:Boolean):void
    {
      if(!value){
        toggle("spectrum-ToggleSwitch--ab",true);
      }
    	_blue = value;
    }
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
          toggle("spectrum-ToggleSwitch--quiet",value);
      }
    	_quiet = value;
    }
  }
}