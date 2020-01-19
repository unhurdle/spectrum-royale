package com.unhurdle.spectrum
{
  public class DialogContent extends Group
  {
    public function DialogContent()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Dialog-content";
    }
    private var textNode:TextNode;
    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      COMPILE::JS
      {
        if(value){
          if(!textNode){
            textNode = new TextNode("");
            textNode.element = element;
          }
          textNode.text = value;
        }

      }
    }
  }
}