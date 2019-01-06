package com.unhurdle.spectrum
{

   COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  public class Search extends SpectrumBase
  {
    public function Search(){
      super();
      typeNames = "spectrum-Search";
    }
    COMPILE::JS
    private var input:HTMLInputElement;
    COMPILE::JS
    private var inputIcon:Icon; 
    COMPILE::JS
    private var inputXlink:String = "#spectrum-css-icon-Magnifier";
    COMPILE::JS
    private var button:HTMLButtonElement;
    COMPILE::JS
    private var buttonIcon:Icon; 
    COMPILE::JS
    private var buttonXlink:String = "#spectrum-css-icon-CrossSmall";
    COMPILE::SWF
    private var input:Object;
    COMPILE::SWF
    private var inputIcon:Object;
    COMPILE::SWF 
    private var inputXlink:String = "#spectrum-css-icon-Magnifier";
    COMPILE::SWF
    private var button:Object;
    COMPILE::SWF
    private var buttonIcon:Object; 
    COMPILE::SWF
    private var buttonXlink:String = "#spectrum-css-icon-CrossSmall";

    private var _quiet:Boolean; 

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(_quiet != value){
        input.className += "spectrum-Textfield--quiet"
        // toggle(valueToSelector("quiet"),value);
      }
    	_quiet = value;
    }

    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        input.disabled = true;
        button.disabled = true;
      }
    	_disabled = value;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
    addElementToWrapper(this,"form");
    input = newElement("input") as HTMLInputElement;
    
    input.type = "search";
    input.placeholder = "Search"; //getters and setters?
    input.name = "search";
    input.value = "";
    input.className = "spectrum-Textfield spectrum-Search-input";
    
    
    inputIcon = new Icon(inputXlink);
    inputIcon.className = "spectrum-Icon spectrum-UIIcon-Magnifier spectrum-Search-icon";
    input.appendChild(inputIcon.getElement());
    
    element.appendChild(input);

    button = newElement("button") as HTMLButtonElement;
    button.type = "reset";
    button.className ="spectrum-ClearButton";

    buttonIcon = new Icon(buttonXlink);
    buttonIcon.className = "spectrum-Icon spectrum-UIIcon-CrossSmall";

    button.appendChild(buttonIcon.getElement());
    element.appendChild(button);

    return element; 
    }
  }

}