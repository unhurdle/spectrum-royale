package com.unhurdle.spectrum
{
  public class TextNode
  {
    public function TextNode(type:String)
    {
      COMPILE::JS
      {
        if(type){
          _element = newElement(type);
          appendTextNode();
        }
      }
    }
    COMPILE::JS
    private var _element:HTMLElement;

    COMPILE::JS
    public function get element():HTMLElement
    {
    	return _element;
    }
    COMPILE::JS
    public function set element(value:HTMLElement):void
    {
    	_element = value;
      if(_textNode){
        _text = _textNode.nodeValue;
      }
      appendTextNode();
   }

    COMPILE::JS
    private function appendTextNode():void{
      _textNode = document.createTextNode(_text) as Text;
      _element.appendChild(_textNode);
    }
    
    COMPILE::JS
    private var _textNode:Text;

    private var _text:String = "";

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      COMPILE::JS
      {
        _textNode.nodeValue = value;
      }
    }

    private var _className:String;

    public function get className():String
    {
    	return _className;
    }

    public function set className(value:String):void
    {
    	_className = value;

      COMPILE::JS
      {
        _element.className = value;
      }
    }
  }
}