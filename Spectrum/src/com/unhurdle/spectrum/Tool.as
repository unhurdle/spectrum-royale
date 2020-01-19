package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.const.IconSize;
  public class Tool extends SpectrumBase
  {
    //TODO the CSS for this exists in Button. We might need to create ButtonBase to import the CSS
    // Also, there is no handling of click and hold to show a menu.
    public function Tool()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Tool";
    }
    private var button:HTMLButtonElement;
    private var iconElement:Icon;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      button = addElementToWrapper(this,'button') as HTMLButtonElement;
      iconElement = new Icon("");
      addElement(iconElement);
      return element;
    }

    public function get icon():String
    {
    	return iconElement.selector;
    }

    public function set icon(value:String):void
    {
    	iconElement.selector = value;
    }
    private var _selected:Boolean;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
      if(value != !!_selected){
        toggle("is-selected",value);
      }
    	_selected = value;
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        button.disabled = true;
      }
    	_disabled = value;
    }
    //TODO rather than setting `cornerTriangle`, we should have a setter for a menu which creates the cornerTriangle automatically.
    // We also need logic to show the menu and change the tools
    private var _cornerTriangle:Boolean;

    public function get cornerTriangle():Boolean
    {
    	return _cornerTriangle;
    }
    private var cornerIcon:Icon;
    public function set cornerTriangle(value:Boolean):void
    {
      if(value != !!_cornerTriangle){
        if(!cornerIcon ){
          var type:String = IconType.CORNER_TRIANGLE;
          cornerIcon = new Icon(Icon.getCSSTypeSelector(type));
          cornerIcon.type = type;
          cornerIcon.className = appendSelector("-hold");
          var cornerElem:HTMLElement = cornerIcon.element as HTMLElement;
          button.appendChild(cornerElem);
          cornerIcon.addedToParent();
        }
        if(value){
          cornerElem.style.display = null;
        } else {
          cornerElem.style.display = "none";
        }
      }

    	_cornerTriangle = value;
    }
  }
}