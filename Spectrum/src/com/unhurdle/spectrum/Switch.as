package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  [Event(name="change", type="org.apache.royale.events.Event")]
  public class Switch extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/toggle/dist.css">
     * </inject_html>
     * 
     */
    public function Switch()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-ToggleSwitch";
    }
    private var label:TextNode;
    private var labelA:TextNode;
    private var input:HTMLInputElement;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      input = newElement("input") as HTMLInputElement;
      input.className = appendSelector("-input");
      input.type = "checkbox";
      elem.appendChild(input);
      var span:HTMLElement = newElement("span");
      span.className = appendSelector("-switch");
      elem.appendChild(span);
      label = new TextNode("label");
      label.className = appendSelector("-label");
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
    private var _textA:String;
    public function get textA():String
    {
      return _textA;
    }

    public function set textA(value:String):void
    {
      _textA = value
      labelA.text = value;
    }
    public function get checked():Boolean
    {
    	return input.checked;
    }

    public function set checked(value:Boolean):void
    {
      if(value != input.checked){
        input.checked = value;
      }
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
        COMPILE::JS{          
          if(!value){          
            labelA = new TextNode("label");
            labelA.className = appendSelector("-label");
            element.insertBefore(labelA.element,input);
            labelA.text = textA;
          }else if(labelA){
            element.removeChild(labelA.element);
            textA = "";
            labelA = null;
          }
        }
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