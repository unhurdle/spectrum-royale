package com.unhurdle.spectrum
{
  COMPILE::JS
  {}

  [Event(name="change", type="org.apache.royale.events.Event")]
/**
 * <input type="text" placeholder="Enter your name" name="field" value="Not a valid input" class="spectrum-Textfield" pattern="[\d]+" required>
 * <input type="text" placeholder="Enter your name" name="field" value="A valid input" class="spectrum-Textfield spectrum-Textfield--quiet is-valid" pattern="[\w\s]+" required disabled>
 */
  public class TextFieldBase extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/textfield/dist.css">
     * </inject_html>
     * 
     */
    public function TextFieldBase()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Textfield";
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

    public function setValidity(value:Boolean):void{
      valid = value;
      invalid = !value;
    }
    private var _valid:Boolean;

    public function get valid():Boolean
    {
    	return _valid;
    }

    public function set valid(value:Boolean):void
    {
      if(value != _valid){
        toggle("is-valid",value);
      }
    	_valid = value;
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
      if(!!value != !!_disabled){
        toggle("is-disabled",value);
      }
      _disabled = value;
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
    	_keyboardFocused = value;
    }

  }
}