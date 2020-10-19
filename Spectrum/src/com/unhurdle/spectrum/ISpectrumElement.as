package com.unhurdle.spectrum
{
  public interface ISpectrumElement
  {
    function toggle(classNameVal:String,add:Boolean):void;
    function setStyle(property:String,value:Object):void;
    function setAttribute(name:String,value:*):void;
    function getAttribute(name:String):*;
    function removeAttribute(name:String):void;
    function get autofocus():Boolean;
    function set autofocus(value:Boolean):void;

  }
  
}