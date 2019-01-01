package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  COMPILE::SWF
  public class TextField extends SpectrumBase{}

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
      typeNames = "";
      element.className = "spectrum-Textfield";
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


    private var input:HTMLInputElement;
    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
      input = addElementToWrapper(this,'input') as HTMLInputElement;
      return element;
    }
  }
}