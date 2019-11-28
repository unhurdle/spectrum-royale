package com.unhurdle.spectrum.typography
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.Group;
  import com.unhurdle.spectrum.TextNode;

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
      var sizeStr:String = isNaN(size) || !size ? "" : "" + size;
      return getTypographySelector() + sizeStr + getSuffix();
    }
    protected function getSuffix():String{
      return "";
    }

    public function get text():String
    {
    	return textNode.text;
    }

    public function set text(value:String):void
    {
    	textNode.text = value;
    }

    protected var _size:Number;

    public function get size():Number
    {
    	return _size;
    }
    protected function getMax():int{
      return 5;
    }
    public function set size(value:Number):void
    {
      if(value != _size){
        value = Math.min(value,getMax());
        value = Math.max(value,1);
        value = Math.round(value);
      	_size = value;
        setTypeNames();
      }
    }

    protected var _textSize:String;

    public function get textSize():String
    {
        return _textSize;
    }
    public function set textSize(value:String):void
    {
      if(value != _textSize){
        if(value){
          _size = 0;
        }
        switch (value){
          case "small":
          case "large":
          case "":
              break;
          default:
              throw new Error("Invalid size: " + value);
        }
        if(_textSize){
          toggle(valueToSelector(_textSize), false);
        }
        if(value == "small" || value == "large"){
          toggle(valueToSelector(value),true);
        }
        _textSize = value;
      }
    }    
    private var _italic:Boolean;

    public function get isItalic():Boolean
    {
        return _italic;
    }

    public function set isItalic(value:Boolean):void
    {
        if(value != !!_italic){
            if(value){
              _size = 0;
            }
            toggle(valueToSelector("italic"),value);
        }
        _italic = value;
    }
    private var _isSecondary:Boolean;

    public function get isSecondary():Boolean
    {
    	return _isSecondary;
    }

    public function set isSecondary(value:Boolean):void
    {
      if(value != !!_isSecondary){
        if(value){
          _size = 0;
        }
        toggle(valueToSelector("secondary"),value);
      }
      _isSecondary = value;
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