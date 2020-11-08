package com.unhurdle.spectrum.data
{
  public class DataItem implements IDataItem
  {
    public function DataItem()
    {      
    }
    private var _disabled:Boolean;
    public function get disabled():Boolean{
      return _disabled;
    }
    public function set disabled(value:Boolean):void{
      _disabled = value;
    }
    private var _selected:Boolean;
    public function get selected():Boolean{
      return _selected;
    }
    public function set selected(value:Boolean):void{
      _selected = value;
    }
    private var _focused:Boolean;
    public function get focused():Boolean{
      return _focused;
    }
    public function set focused(value:Boolean):void{
      _focused = value;
      if(value){
        keyboardFocused = !value;
      }
    }
    private var _keyboardFocused:Boolean;
    public function get keyboardFocused():Boolean{
      return _keyboardFocused;
    }
    public function set keyboardFocused(value:Boolean):void{
      _keyboardFocused = value;
      if(value){
        focused = !value;
      }
    }
  }
}