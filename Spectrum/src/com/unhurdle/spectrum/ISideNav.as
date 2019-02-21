package com.unhurdle.spectrum
{
  public interface ISideNav
  {
    function get color():String;
		function set color(value:String):void;
    function get text():String;
		function set text(value:String):void;
    function get label():String;
    function get disabled():Boolean;
		function set disabled(value:Boolean):void;
    function get isHeading():Boolean;
		function set isHeading(value:Boolean):void;
		function set dataProvider(value:Object):void;
    
  } 
}