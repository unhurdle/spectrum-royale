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