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

  }
}