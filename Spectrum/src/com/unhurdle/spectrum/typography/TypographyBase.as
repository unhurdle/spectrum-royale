package com.unhurdle.spectrum.typography
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.Group;
  import com.unhurdle.spectrum.TextNode;

  public class TypographyBase extends Group
  {
    public function TypographyBase()
    {
      super();
    }
    public function get text():String
    {
    	return textNode.text;
    }

    public function set text(value:String):void
    {
    	textNode.text = value;
    }

    protected function getTag():String{
      return "p";
    }

    protected var textNode:TextNode;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,getTag());
      textNode = new TextNode("");
      textNode.element = element;
      return element;
    }
  }
}