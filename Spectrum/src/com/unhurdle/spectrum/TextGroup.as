package com.unhurdle.spectrum
{

  public class TextGroup extends Group implements ITextContent
  {
    public function TextGroup()
    {
      super();
    }


    public function get text():String
    {
      COMPILE::SWF{return ""}
      COMPILE::JS
      {
        if(!textNode){
          return "";
        }
      	return textNode.text;
      }
    }

    public function set text(value:String):void
    {
      COMPILE::JS
      {
        if(!textNode){
          createTextNode();
        }
      	textNode.text = value;
      }
    }
    COMPILE::JS
    protected var textNode:TextNode;


    COMPILE::JS
    protected function createTextNode():void{
      textNode = new TextNode("");
      textNode.element = element;
    }

  }
}