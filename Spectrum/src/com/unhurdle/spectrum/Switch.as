package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.events.Event;
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
    private var _rightLabelElem:TextNode;
    private var _leftLabelElem:TextNode;
    private var input:HTMLInputElement;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      input = newElement("input") as HTMLInputElement;
      input.className = appendSelector("-input");
      input.type = "checkbox";
      input.addEventListener("change",handleInputChange);
      elem.appendChild(input);
      var span:HTMLElement = newElement("span");
      span.className = appendSelector("-switch");
      elem.appendChild(span);
      return elem;
    }
    override public function addedToParent():void{
      super.addedToParent();
      COMPILE::JS
      {
        if(_leftLabel && !_leftLabelElem){
          _leftLabelElem = new TextNode("label");
          _leftLabelElem.className = appendSelector("-label");
          _leftLabelElem.text = _leftLabel;
          element.insertBefore(_leftLabelElem.element,input);
        }
        if(_rightLabel || !_leftLabelElem){
          _rightLabelElem = new TextNode("label");
          _rightLabelElem.className = appendSelector("-label");
          _rightLabelElem.text = _rightLabel;
          element.appendChild(_rightLabelElem.element);
        }
        handleInputChange(null);
      }
    }
    private function handleInputChange(ev:Event):void{
      var label:String = input.checked ? onLabel : offLabel;
      if(label){
        if(_rightLabelElem){
          _rightLabelElem.text = label;
        }
        if(_leftLabelElem){
          _leftLabelElem.text = label
        }
      } else {
        if(_rightLabelElem){
          _rightLabelElem.text = _rightLabel;
        }
        if(_leftLabelElem){
          _leftLabelElem.text = _leftLabel;
        }
      }
    }
    public var onLabel:String;
    public var offLabel:String;
    private var _rightLabel:String = "";
    public function get rightLabel():String
    {
      return _rightLabel;
    }

    public function set rightLabel(value:String):void
    {
      _rightLabel = value
      if(_rightLabelElem){
        _rightLabelElem.text = value;
      }
    }
    private var _leftLabel:String = "";
    public function get leftLabel():String
    {
      return _leftLabel;
    }

    public function set leftLabel(value:String):void
    {
      _leftLabel = value
      if(_leftLabelElem){
        _leftLabelElem.text = value;
      }
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