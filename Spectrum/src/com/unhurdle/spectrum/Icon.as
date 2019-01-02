package com.unhurdle.spectrum
{
  public class Icon
  {
    public function Icon(selector:String)
    {
      COMPILE::JS
      {
        _element = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
        _element.setAttribute("focusable", false);
        _element.setAttribute("aria-hidden",true);
        useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
        useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', selector);
        _element.appendChild(useElement);
        _selector = selector;
      }
    }

    private var _selector:String;

    public function get selector():String
    {
    	return _selector;
    }

    public function set selector(value:String):void
    {
    	_selector = value;
      COMPILE::JS
      {
        useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', value);
      }
    }

    COMPILE::SWF
    public function getElement():Object{
      return null;
    }

    COMPILE::JS
    private var _element:SVGElement;    
    COMPILE::JS
    public function getElement():SVGElement{
      return _element;
    }
    public function setAttribute(name:String, value:Object):void{
      COMPILE::JS
      {
        _element.setAttribute(name,value);
      }
    }
    public function removeAttribute(name:String):void{
      COMPILE::JS
      {
        _element.removeAttribute(name);
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
        _element.setAttribute("class",value);
      }
    }
    COMPILE::JS
    private var useElement:SVGUseElement;

  }
}