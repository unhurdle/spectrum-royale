package com.unhurdle.spectrum
{

  public class TextBase extends SpectrumBase implements ITextContent
  {
    public function TextBase()
    {
      super();
      userSelect = true;
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

    private var _userSelect:Boolean;

    public function get userSelect():Boolean
    {
    	return _userSelect;
    }

    public function set userSelect(value:Boolean):void
    {
    	_userSelect = value;
      if(value){
        setAttribute("user-select","");
      } else {
        setAttribute("user-select","none");
      }
    }
  }
}