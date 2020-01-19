package com.unhurdle.spectrum
{
  public class TextNode
  {
    public function TextNode(type:String)
    {
      if(type){
        _element = newElement(type);
        appendTextNode();
      }
    }
    private var _element:HTMLElement;

    public function get element():HTMLElement
    {
    	return _element;
    }
    public function set element(value:HTMLElement):void
    {
    	_element = value;
      if(_textNode){
        _text = _textNode.nodeValue;
      }
      appendTextNode();
   }

    private function appendTextNode():void{
      _textNode = document.createTextNode(_text) as Text;
      _element.appendChild(_textNode);
    }
    
    private var _textNode:Text;

    private var _text:String = "";

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      _textNode.nodeValue = value;
    }

    private var _className:String;

    public function get className():String
    {
    	return _className;
    }

    public function set className(value:String):void
    {
    	_className = value;
      _element.className = value;
    }
    public function setAttribute(name:String,value:*):void
    {
      COMPILE::JS
      {
        element.setAttribute(name,value);
      }            
    }

  }
}