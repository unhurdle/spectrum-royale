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
  public class TextField extends SpectrumBase
  {
    public function TextField()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Textfield";
    }
    // public function get color():String
    // {
    //   return input.style.backgroundColor;
    // }

    public function set color(value:String):void
    {
      input.style.backgroundColor = value;
      input.style.borderColor = value;
    }
    
    public function set textColor(value:String):void
    {
      input.style.color = value;
    }
    // public function set fontSize(value:String):void
    // {
    //   input.style.color = value;
    // }
    public function set font(value:String):void
    {
      // if(value != _font){
        switch (value){
        // check that values are valid
        case "small":
        case "large":
        // case "smaller":
        // case "larger":
        case "x-small":
        case "x-large":
        // case "xx-small":
        // case "xx-large":
        case "medium":
            break;
        default:
            throw new Error("Invalid font: " + value);
        }
        input.style.fontSize = value;
        // var oldFont:String = valueToSelector(_font);
        // var newFont:String = valueToSelector(value);
        // toggle(newFont, true);
        // toggle(oldFont, false);
      //   _font = value;
      // }
    }

    public function get placeholder():String
    {
    	return input.placeholder;
    }

    public function set placeholder(value:String):void
    {
      if(value){
      	input.placeholder = value;
      } else {
        input.removeAttribute("placeholder");
      }
    }

    COMPILE::JS
    public function get name():String
    {
    	return input.name;
    }

    COMPILE::JS
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
      if(value){
      	input.value = value;
      } else {
        input.value = "";
      }
    }

    private var _pattern:String;

    public function get pattern():String
    {
    	return _pattern;
    }

    public function set pattern(value:String):void
    {
      if(value != _pattern){
        if(value){
          input.pattern = value;
        } else {
          input.removeAttribute("pattern")
        }
      }
      _pattern = value;
    }
    private var _required:Boolean;
    public function get required():Boolean
    {
    	return input.required;
    }

    public function set required(value:Boolean):void
    {
      if(!!value != !!_required){
      	input.required = value;
      }
      _required = value;
    }
    private var _left:Boolean;
    public function get left():Boolean
    {
    	return _left;
    }

    public function set left(value:Boolean):void
    {
      if(!!value != !!_left){
      	toggle(appendSelector("left"),true);
      }
      _left = value;
    }

    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(!!value != !!_disabled){
        input.disabled = value;
      }
      _disabled = value;
    }
    private var _multiline:Boolean;
    public function get multiline():Boolean
    {
    	return _multiline;
    }

    public function set multiline(value:Boolean):void
    {
      if(!!value != !!_multiline){
      	toggle(appendSelector("multiline"),value);
      }
      _multiline = value;
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
    protected var input:HTMLInputElement;

    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
      input = addElementToWrapper(this,'input') as HTMLInputElement;
      return element;
    }
  }
}