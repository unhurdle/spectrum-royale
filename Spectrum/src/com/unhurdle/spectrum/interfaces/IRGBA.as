package com.unhurdle.spectrum.interfaces
{
  public interface IRGBA
  {
    function get r():Number;
    function set r(value:Number):void;
    function get g():Number;
    function set g(value:Number):void;
    function get b():Number;
    function set b(value:Number):void;
    function get alpha():Number;
    function set alpha(value:Number):void;
    function get colorValue():uint;
    function get styleString():String;
    function clone():IRGBA;
    {
      
    }
  }
}