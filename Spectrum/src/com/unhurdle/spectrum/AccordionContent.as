package com.unhurdle.spectrum
{

  public class AccordionContent extends Group
  {
    public function AccordionContent()
    {
      super();
    }

    override protected function getSelector():String{
      return "spectrum-Accordion-itemContent";
    }

    COMPILE::JS
    private var _textNode:Text;

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
        if(!_textNode){
          _textNode = document.createTextNode(_text) as Text;
          _element.appendChild(_textNode);
        }
        _textNode.nodeValue = value;

      }
    }

  }
}