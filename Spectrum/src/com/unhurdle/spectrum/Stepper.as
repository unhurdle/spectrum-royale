package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.events.Event;
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.html.elements.Span;
  
  [Event(name="change", type="org.apache.royale.events.Event")]
  public class Stepper extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/stepper/dist.css">
     * </inject_html>
     * 
     */
    public function Stepper()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Stepper";
    }
    private function button1Clicked(event:Event):void{
      event.preventDefault();
      nudgeValue(true);
    }
    private function button2Clicked(event:Event):void{
      event.preventDefault();
      nudgeValue(false);
    }
    private function nudgeValue(up:Boolean):void{
			var stepVal:Number = step;
      if(!up){
        stepVal = -stepVal;
      }
      var newVal:Number = value + stepVal;
			var rem:Number = newVal % stepVal;
      rem = isNaN(rem) ? 0 : rem;
			newVal = newVal - rem;
      newVal = Math.min(newVal,max);
      newVal = Math.max(newVal,min);
			value = newVal;
      dispatchEvent(new Event("change"));
    }
    private function inputChanged():void
    {
      var val:Number = value;
      val = Math.min(val,max);
      val = Math.max(val,min);
      value = val;
    }
    
    private var input:NumberField;
    private var button1:FieldButton;
    private var button2:FieldButton;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      input = new NumberField();
      input.className =  appendSelector("-textfield");
      input.input.classList.add(appendSelector("-input"));
      // default to any valid integer
      input.min = Number.MIN_SAFE_INTEGER;
      input.max = Number.MAX_SAFE_INTEGER;
      input.addEventListener(Event.CHANGE,inputChanged);
      addElement(input);
      var span:Span = new Span();
      // var span:HTMLSpanElement = newElement("span") as HTMLSpanElement;
      span.className = appendSelector("-buttons");
      button1 = new FieldButton();
      button1.className = appendSelector("-stepUp");
      var type:String = IconType.CHEVRON_UP_SMALL;
      button1.icon = Icon.getCSSTypeSelector(type);
      button1.iconType = type;
      button1.addEventListener(MouseEvent.CLICK,button1Clicked);
      span.addElement(button1);
      button2 = new FieldButton();
      button2.className = appendSelector("-stepDown");
      type = IconType.CHEVRON_DOWN_SMALL
      button2.icon = Icon.getCSSTypeSelector(type);
      button2.iconType = type;
      button2.addEventListener(MouseEvent.CLICK,button2Clicked);
      span.addElement(button2);
      addElement(span);
      return elem;
    }
    public function get placeholder():String
    {
      return input.placeholder;
    }

    public function set placeholder(value:String):void
    {
      input.placeholder = value;
    }
    private var _value:Number;

    public function get value():Number
    {
    	return input.value;
    }

    public function set value(value:Number):void
    {
    	input.value = value;
    }
     public function get min():Number
    {
      return input.min;
    }

    public function set min(value:Number):void
    {
      input.min = value;
    }
    public function get max():Number
    {
      return input.max;
    }

    public function set max(value:Number):void
    {
      input.max = value;
    }
     public function get step():Number
    {
      return input.step;
    }

    public function set step(value:Number):void
    {
      input.step = value;
    }
    private var _focused:Boolean;

    public function get focused():Boolean
    {
    	return _focused;
    }

    public function set focused(value:Boolean):void
    {
      if(value != _focused){
        toggle("is-focused",value);
      }
    	_focused = value;
    }
    private var _keyboardFocused:Boolean;

    public function get keyboardFocused():Boolean
    {
    	return _keyboardFocused;
    }

    public function set keyboardFocused(value:Boolean):void
    {
      if(value != _keyboardFocused){
        toggle("is-keyboardFocused",value);
      }
    	_focused = value;
    }
    private var _invalid:Boolean;

    public function get invalid():Boolean
    {
    	return _invalid;
    }

    public function set invalid(value:Boolean):void
    {
      if(value != _invalid){
        toggle("is-invalid",value);
      }
    	_invalid = value;
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
        input.disabled = value;
        button1.disabled = value;
        button2.disabled = value;
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
        input.quiet = value;
        button1.quiet = value;
        button2.quiet = value;
      }
    	_quiet = value;
    }
  }
}