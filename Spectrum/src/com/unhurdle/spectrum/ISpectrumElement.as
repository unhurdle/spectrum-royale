package com.unhurdle.spectrum
{
  import org.apache.royale.core.IParentIUIBase;

  public interface ISpectrumElement extends IParentIUIBase
  {
    function toggle(classNameVal:String,add:Boolean):void;
    function setStyle(property:String,value:Object):void;
    function setAttribute(name:String,value:*):void;
    function getAttribute(name:String):*;
    function removeAttribute(name:String):void;
    function get autofocus():Boolean;
    function set autofocus(value:Boolean):void;
    function get focusable():Boolean;
    function set focusable(value:Boolean):void;
    function focus():void;

  }
  
}