package com.unhurdle.spectrum
{
  COMPILE::JS
  {}
  import com.unhurdle.spectrum.includes.SideNavInclude;

  public class SideNavHeading extends SideNav implements ITextContent
  {
    public function SideNavHeading(text:String = "")
    {
      super();
      this.text = text;
    }
    
    override protected function getSelector():String{
      return SideNavInclude.getSelector() + "-heading";
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