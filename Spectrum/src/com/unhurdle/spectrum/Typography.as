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
    protected function getTypographySelector():String{
      return "";
    }
    override protected function getSelector():String{
      var sizeStr:String = size ? "" + size : "";
      var suffix:String = "";
      if(quiet){
        suffix = "--quiet";
      } else if(strong){
        suffix = "--strong";
      }
      return getTypographySelector() + size + suffix;
    }

    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
        _strong = false;
      	_quiet = value;
        setTypeNames();
      }
    }
    private var _strong:Boolean;

    public function get strong():Boolean
    {
    	return _strong;
    }

    public function set strong(value:Boolean):void
    {
      if(value != !!_strong){
      	_strong = value;
        _quiet = false;
        setTypeNames();
      }
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
        value = Math.min(value,5);
        value = Math.max(value,1);
        value = Math.round(value);
      	_size = value;
        setTypeNames();
      }
    }

    protected function setTypeNames():void{
      typeNames = getSelector();
      COMPILE::JS
      {
        setClassName(computeFinalClassNames());
      }
    }

    protected var textNode:TextNode;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,"p");
      textNode = new TextNode("");
      textNode.element = element;
      return element;
    }
  }
}