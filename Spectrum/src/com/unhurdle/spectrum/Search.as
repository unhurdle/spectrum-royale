package com.unhurdle.spectrum
{

   COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconType;

  public class Search extends SpectrumBase
  {
    public function Search(){
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Search";
    }
    private var input:TextField;
    private var inputIcon:Icon;
    private var button:ClearButton;

    private var _quiet:Boolean; 

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(_quiet != value){
        input.quiet = value;
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
        input.disabled = value;
        button.disabled = value;
      }
    	_disabled = value;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
    addElementToWrapper(this,"form");
    input = new TextField();
    input.placeholder = "Search"; //getters and setters?
    input.className = appendSelector("-input");
    //TODO forward events
    addElement(input);
    var type:String = IconType.MAGNIFIER;
    inputIcon = new Icon(IconPrefix.SPECTRUM_CSS_ICON + type);
    inputIcon.type = type;
    inputIcon.className = appendSelector("-icon");
    addElement(inputIcon);
    button = new ClearButton();
    button.small = true;

    addElement(button);

    return element; 
    }
  }

}