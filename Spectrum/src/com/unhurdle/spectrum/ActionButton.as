package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
//get the vars for SWF too 
  public class ActionButton extends SpectrumBase
  {
    public static const WITH_TEXT:String = "withText";
    public static const WITH_TEXT_AND_PICTURE:String = "withTextAndPicture";
    public static const WITH_PICTURE:String = "withPicture";
    public static const WITH_PICTURE_AND_FLYOUT:String = "withPictureAndFlyout";
    public function ActionButton()
    {
      super()
      typeNames = "spectrum-ActionButton" ;
      _text = "";
    }

    private function valueToCSS(value:String):String{
        return "spectrum-ActionButton--" + value;
    } 

    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
       span.text = value;
    	_text = value;
    }
    private var iconHolder:Icon;
    private var _icon:String;

    public function get icon():String
    {
    	return _icon;
    }

    public function set icon(value:String):void
    {
    	_icon = value;
    }
    private var flyOutIconHolder:Icon;
    private var _flyOutIcon:String;

    public function get flyOutIcon():String
    {
    	return _flyOutIcon;
    }

    public function set flyOutIcon(value:String):void
    {
    	_flyOutIcon = value;
    }
    COMPILE::JS
    private var _flavor:String;
    COMPILE::SWF
    private var _flavor:String;

    public function get flavor():String
    {
    	return _flavor;
    }
    COMPILE::JS
    public function set flavor(value:String):void
    {
       _flavor = value;
       setType(value);
    }
    private var span:TextNode;
    COMPILE::JS
    private function setType(flavor:String):void
    {
      COMPILE::JS
      switch(flavor){
        case ActionButton.WITH_TEXT:
        span = new TextNode("");
        span.element = newElement("span") as HTMLSpanElement;
        span.className = "spectrum-Button-label";
        element.appendChild(span.element);
          break;
        case ActionButton.WITH_PICTURE: 
        icon ="#spectrum-icon-18-Edit";
        iconHolder = new Icon(icon);
        iconHolder.className = "spectrum-Icon spectrum-Icon--sizeS";
        element.appendChild(iconHolder.getElement());
          break;
        case ActionButton.WITH_TEXT_AND_PICTURE:
        COMPILE::JS
        setType(ActionButton.WITH_PICTURE);
        COMPILE::JS
        setType(ActionButton.WITH_TEXT);
          break;
        case ActionButton.WITH_PICTURE_AND_FLYOUT: 
        COMPILE::JS
        setType(ActionButton.WITH_PICTURE);
        flyOutIcon = "#spectrum-css-icon-CornerTriangle";
        flyOutIconHolder = new Icon(flyOutIcon);
        flyOutIconHolder.className = "spectrum-Icon spectrum-UIIcon-CornerTriangle spectrum-ActionButton-hold";
        element.appendChild(flyOutIconHolder.getElement());
          break;
        case "default":
        setType(ActionButton.WITH_TEXT);
        break;
      }
    }

    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(_quiet != value){
        toggle(valueToCSS("quiet"),value);
      }
    	_quiet = value;
    }
    COMPILE::JS
    private var button:HTMLButtonElement;

    COMPILE::SWF
    private var button:Object;

    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
      return _disabled;
    }
    // COMPILE::JS
    public function set disabled(value:Boolean):void
    {
        if(value != !!_disabled){
            button.disabled = value;
        }
      _disabled = value;
    }

    private function elementClicked():void{
      toggle(valueToCSS("is-selected"),true);
    }

    COMPILE::JS
    private var iconElement:SVGElement;
   

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'button');
      flavor = "default";
      element.onclick = elementClicked;
      return element;
    }


  }
}