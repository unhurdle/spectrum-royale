package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

/**
 * <button class="spectrum-Button spectrum-Button--cta" disabled>
    <span class="spectrum-Button-label">Button</span>
    </button>
<button class="spectrum-Button spectrum-Button--overBackground" disabled>
    <span class="spectrum-Button-label">Button</span>
  </button>
<button class="spectrum-Button spectrum-Button--primary">
  <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" aria-hidden="true" aria-label="Edit">
    <use xlink:href="#spectrum-icon-18-Edit" />
  </svg>
  <span class="spectrum-Button-label">Edit</span>
</button>
 */


  public class Button extends SpectrumBase
  {
    public static const CTA:String = "cta";
    public static const PRIMARY:String = "primary";
    public static const SECONDARY:String = "secondary";
    public static const WARNING:String = "warning";
    public static const OVER_BACKGROUND:String = "overBackground";

    public function Button()
    {
      super();
      _flavor = "primary";
      typeNames = "spectrum-Button";
      toggle("spectrum-Button--primary",true);
      _text = "";
    }
    private function valueToCSS(value:String):String{
        return "spectrum-Button--" + value;
    }

    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
      if(value != _text){
        textNode.nodeValue = value;
      }
    	_text = value;
    }
    private var _icon:String;

    public function get icon():String
    {
    	return _icon;
    }

    public function set icon(value:String):void
    {
    	_icon = value;
    }
    private var _flavor:String;

    public function get flavor():String
    {
    	return _flavor;
    }

    public function set flavor(value:String):void
    {
      if(value != _flavor){
        switch(value){
          case "cta":
          case "primary":
          case "secondary":
          case "warning":
          case "overBackground":
          case "":
            break;
          default:
            throw new Error("Unexpected flavor: " + value);
        }
        if(_flavor){
          var oldSelector:String = valueToCSS(_flavor);
          toggle(oldSelector,false);
        }
        if(value){
          var newSelector:String = valueToCSS(value);
          toggle(newSelector,true);
        }
      }
    	_flavor = value;
    }

    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(_quiet != value){
        toggle("spectrum-Button--quiet",value);
      }
    	_quiet = value;
    }

    COMPILE::JS
    private var iconElement:SVGElement;
    
    COMPILE::JS
    private var textNode:Text;
    
    COMPILE::SWF
    private var textNode:Object;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'button');
      if(icon){
        // add in icon
      }
      var span:HTMLSpanElement = newElement("span") as HTMLSpanElement;
      span.className = "spectrum-Button-label";
      textNode = newTextNode(_text);
      span.appendChild(textNode);
      element.appendChild(span);
      return element;
    }
  }
}