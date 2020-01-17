package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  public class DialogTitle extends Group
  {
    public function DialogTitle()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Dialog-title";
    }
    public function get text():String
    {
      COMPILE::SWF{return ""}
      COMPILE::JS
      {
      	return textNode.text;
      }
    }

    public function set text(value:String):void
    {
      COMPILE::JS
      {
      	textNode.text = value;
      }
    }
    COMPILE::JS
    private var textNode:TextNode
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'h2') as WrappedHTMLElement;
      textNode = new TextNode("");
      textNode.element = elem;
      return elem;
    }

  }
}