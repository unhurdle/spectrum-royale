package com.unhurdle.spectrum.interfaces
{
  public interface IKeyboardFocusable
  {
    function get focusElement():HTMLElement;
    function set keyboardFocused(value:Boolean):void;
    function set focused(value:Boolean):void;
  }
}