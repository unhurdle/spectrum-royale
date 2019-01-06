package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class Typography extends Group
  {
    public static const STRONG:String = "strong;"
    public static const QUIET:String = "quiet;"
    public static const NORMAL:String = "normal;"

    public function Typography()
    {
      super();
    }
    private var _flavor:String;

    public function get flavor():String
    {
    	return _flavor;
    }

    public function set flavor(value:String):void
    {
      if(value != _flavor){
        if(_flavor){
          toggle(valueToSelector(_flavor),false);
        }
        if(value == "normal"){
          // no selector
          return;
        }

      }
      switch(value){
        case "strong":
        case "quiet":
          break;
        default:
          throw new Error("invalid flavor: " + value);
      }
      toggle(valueToSelector(value),false);
    	_flavor = value;
    }

    public function get text():String
    {
    	return textNode.text;
    }

    public function set text(value:String):void
    {
    	textNode.text = value;
    }

    private var _size:Number;

    public function get size():Number
    {
    	return _size;
    }
    public function set size(value:Number):void
    {
      if(value != _size){
        switch(value){
          case 1:
          case 2:
          case 3:
          case 4:
          case 5:
            break;
          default:
            throw new Error("Invalid scale: " + value);
        }
      }
    	_size = value;
    }

    private var textNode:TextNode;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,"p");
      textNode = new TextNode("");
      textNode.element = element;
      return element;
    }
  }
}