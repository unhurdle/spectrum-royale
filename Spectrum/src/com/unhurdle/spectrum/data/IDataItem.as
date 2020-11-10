package com.unhurdle.spectrum.data
{
  public interface IDataItem
  {
    function get disabled():Boolean;
    function set disabled(value:Boolean):void;
    function get selected():Boolean;
    function set selected(value:Boolean):void;
    function get keyboardFocused():Boolean;
    function set keyboardFocused(value:Boolean):void;
  }
}