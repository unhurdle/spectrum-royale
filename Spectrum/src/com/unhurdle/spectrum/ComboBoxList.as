package com.unhurdle.spectrum
{
  public class ComboBoxList extends Popover
  {
    public function ComboBoxList()
    {
      _list = new List();
    }
    private var _list:List;

    public function get list():List
    {
    	return _list;
    }

    public function set list(value:List):void
    {
    	_list = value;
    }

  }
}