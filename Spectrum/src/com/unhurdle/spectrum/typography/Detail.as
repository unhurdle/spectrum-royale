package com.unhurdle.spectrum.typography
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.Group;
  import com.unhurdle.spectrum.TextNode;

  public class Detail extends Group
  {
    public function Detail()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Detail";
    }
    public function get text():String
    {
    	return textNode.text;
    }

    public function set text(value:String):void
    {
    	textNode.text = value;
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