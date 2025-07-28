package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.events.Event;
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.html.elements.Span;
  import com.unhurdle.spectrum.interfaces.IKeyboardFocusable;
  import com.unhurdle.spectrum.beads.KeyboardFocusHandler;
  import org.apache.royale.utils.number.pinValue;
  
  [Event(name="change", type="org.apache.royale.events.Event")]
  public class Stepper extends SpectrumBase implements IKeyboardFocusable
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
    override protected function loadBeads():void{
      super.loadBeads();
      addBead(new KeyboardFocusHandler());
    }
    override protected function getSelector():String{
      return "spectrum-Stepper";
    }

    public function get focusElement():HTMLElement{
      return numberField.focusElement;
    }

    private function upButtonClicked(event:Event):void{
      event.preventDefault();
      nudgeValue(true);
    }
    private function downButtonClicked(event:Event):void{
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
			value = pinValue(newVal - rem, min, max);
      dispatchEvent(new Event("change"));
    }
    private function inputChanged():void{
      if(!numberField.input.value){
        return;
      }
      value = pinValue(value,min,max);
    }
    
    private var numberField:NumberField;
    private var upButton:FieldButton;
    private var downButton:FieldButton;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      numberField = new NumberField();
      numberField.className =  appendSelector("-textfield");
      numberField.input.classList.add(appendSelector("-input"));
      // default to any valid integer
      numberField.min = Number.MIN_SAFE_INTEGER;
      numberField.max = Number.MAX_SAFE_INTEGER;
      numberField.addEventListener(Event.CHANGE,inputChanged);
      addElement(numberField);
      var span:Span = new Span();
      // var span:HTMLSpanElement = newElement("span") as HTMLSpanElement;
      span.className = appendSelector("-buttons");
      upButton = getButton("-stepUp",IconType.CHEVRON_UP_SMALL);
      upButton.addEventListener(MouseEvent.CLICK,upButtonClicked);
      span.addElement(upButton);
      downButton = getButton("-stepDown",IconType.CHEVRON_DOWN_SMALL);
      downButton.addEventListener(MouseEvent.CLICK,downButtonClicked);
      span.addElement(downButton);
      addElement(span);
      return elem;
    }
    private function getButton(selector:String,type:String):FieldButton{
      var button:FieldButton = new FieldButton();
      button.tabFocusable = false;
      button.className = appendSelector(selector);
      button.icon = Icon.getCSSTypeSelector(type);
      button.iconType = type;
      return button;
    }
    public function get placeholder():String
    {
      return numberField.placeholder;
    }

    public function set placeholder(value:String):void
    {
      numberField.placeholder = value;
    }
    public function inputValue():String{
      return numberField.input.value;
    }
    private var _value:Number;

    public function get value():Number
    {
    	return numberField.value;
    }

    public function set value(value:Number):void
    {
    	numberField.value = value;
    }
     public function get min():Number
    {
      return numberField.min;
    }

    public function set min(value:Number):void
    {
      numberField.min = value;
    }
    public function get max():Number
    {
      return numberField.max;
    }

    public function set max(value:Number):void
    {
      numberField.max = value;
    }
     public function get step():Number
    {
      return numberField.step;
    }

    public function set step(value:Number):void
    {
      numberField.step = value;
    }
    /**
     * A suffix is some text attached to the value such as px or %
     */
    public function get suffix():String{
    	return numberField.suffix;
    }

    public function set suffix(value:String):void{
    	numberField.suffix = value;
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
        if(value){
          toggle("is-keyboardFocused",false);
        }
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
        if(value){
          toggle("is-focused",false);
        }
      }
    	_keyboardFocused = value;
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
        numberField.disabled = value;
        upButton.disabled = value;
        downButton.disabled = value;
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
        numberField.quiet = value;
        upButton.quiet = value;
        downButton.quiet = value;
      }
    	_quiet = value;
    }
  }
}