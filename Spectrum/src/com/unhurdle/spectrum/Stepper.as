package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.events.Event;
  
  [Event(name="change", type="org.apache.royale.events.Event")]
  public class Stepper extends SpectrumBase
  {
    public function Stepper()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Stepper";
    }
    private function button1Clicked():void{
      nudgeValue(true);
    }
    private function button2Clicked():void{
      nudgeValue(false);
    }
    private function nudgeValue(up:Boolean):void{
			var stepVal:Number = step;
      if(!up){
        stepVal = -stepVal;
      }
      var newVal:Number = value + stepVal;
			var rem:Number = newVal % stepVal;
			newVal = newVal - rem;
      newVal = Math.min(newVal,max);
      newVal = Math.max(newVal,min);
			value = newVal;
      dispatchEvent(new Event("change"));
    }
    COMPILE::JS{
      private var input:HTMLInputElement;
      private var button1:HTMLButtonElement;
      private var button2:HTMLButtonElement;
    }
    COMPILE::SWF{
      private var input:Object;
      private var button1:Object;
      private var button2:Object;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      input = newElement("input") as HTMLInputElement;
      input.className = "spectrum-Textfield spectrum-Stepper-input";
      input.type = "number";
      elem.appendChild(input);
      var span:HTMLSpanElement = newElement("span") as HTMLSpanElement;
      span.className = "spectrum-Stepper-buttons";
      button1 = newElement("button") as HTMLButtonElement;
      button1.className = "spectrum-ActionButton spectrum-Stepper-stepUp";
      var icon1:Icon = new Icon("#spectrum-css-icon-ChevronUpSmall");
      icon1.className = "spectrum-Icon spectrum-UIIcon-ChevronUpSmall spectrum-Stepper-stepUpIcon";
      icon1.selector = "#spectrum-css-icon-ChevronUpSmall";
      button1.appendChild(icon1.getElement());
      button1.onclick = button1Clicked;
      span.appendChild(button1);
      button2 = newElement("button") as HTMLButtonElement;
      button2.className = "spectrum-ActionButton spectrum-Stepper-stepDown";
      var icon2:Icon = new Icon("#spectrum-css-icon-ChevronDownSmall" );
      icon2.className = "spectrum-Icon spectrum-UIIcon-ChevronDownSmall spectrum-Stepper-stepDownIcon";
      icon2.selector = "#spectrum-css-icon-ChevronDownSmall" ;
      button2.appendChild(icon2.getElement());
      button2.onclick = button2Clicked;
      span.appendChild(button2);
      elem.appendChild(span);
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
    	return Number(input.value);
    }

    public function set value(value:Number):void
    {
    	input.value = ""+value;
    }
     public function get min():Number
    {
      return Number(input.min);
    }

    public function set min(value:Number):void
    {
      input.min = ""+value;
    }
    public function get max():Number
    {
      return Number(input.max);
    }

    public function set max(value:Number):void
    {
      input.max = "" + value;
    }
     public function get step():Number
    {
      return Number(input.step);
    }

    public function set step(value:Number):void
    {
      input.step = "" + value;
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
        value ? input.classList.add("spectrum-Textfield--quiet") : input.classList.remove("spectrum-Textfield--quiet");
        value ? button1.classList.add("spectrum-ActionButton--quiet") : button1.classList.remove("spectrum-ActionButton--quiet");
        value ? button2.classList.add("spectrum-ActionButton--quiet") : button2.classList.remove("spectrum-ActionButton--quiet");
      }
    	_quiet = value;
    }
  }
}