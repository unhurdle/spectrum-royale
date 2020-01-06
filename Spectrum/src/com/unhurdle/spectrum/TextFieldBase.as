package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

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
    	return _invalid;
    }

    public function set valid(value:Boolean):void
    {
      if(value != _invalid){
        toggle("is-valid",value);
      }
    	_invalid = value;
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

  }
}