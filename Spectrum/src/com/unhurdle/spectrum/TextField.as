package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  COMPILE::SWF
  public class TextField extends SpectrumBase{
    public var placeholder:String;
    public var text:String;
    public var pattern:String;
    public var required:Boolean;
    public var disabled:Boolean;
  }

/**
 * <input type="text" placeholder="Enter your name" name="field" value="Not a valid input" class="spectrum-Textfield" pattern="[\d]+" required>
 * <input type="text" placeholder="Enter your name" name="field" value="A valid input" class="spectrum-Textfield spectrum-Textfield--quiet is-valid" pattern="[\w\s]+" required disabled>
 */
  COMPILE::JS
  public class TextField extends SpectrumBase
  {
    public function TextField()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Textfield";
    }


    public function get placeholder():String
    {
    	return input.placeholder;
    }

    public function set placeholder(value:String):void
    {
    	input.placeholder = value;
    }

    public function get name():String
    {
    	return input.name;
    }

    public function set name(value:String):void
    {
        input.name = name;
    }

    public function get text():String
    {
      return input.value;
    }

    public function set text(value:String):void
    {
    	input.value = value;
    }

    private var _pattern:String;

    public function get pattern():String
    {
    	return input.pattern;
    }

    public function set pattern(value:String):void
    {
    	input.pattern = value;
    }

    public function get required():Boolean
    {
    	return input.required;
    }

    public function set required(value:Boolean):void
    {
    	input.required = value;
    }

    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != _disabled){
        input.disabled = value;
      }
      _disabled = value;
    }

    private var input:HTMLInputElement;
    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
      input = addElementToWrapper(this,'input') as HTMLInputElement;
      return element;
    }
  }
}