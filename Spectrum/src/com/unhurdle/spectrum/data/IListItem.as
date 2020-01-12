package com.unhurdle.spectrum.data
{
  public interface IListItem
  {
    function get text():String;
    function set text(value:String):void;
    function get label():String;
    function get icon():String;
    function set icon(value:String):void;

    /**
     * src of an icon to be rendered an an img
     */
    function get imageIcon():String;
    function set imageIcon(value:String):void;

  }
}