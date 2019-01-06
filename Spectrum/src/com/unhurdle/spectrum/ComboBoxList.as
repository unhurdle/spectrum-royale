package com.unhurdle.spectrum
{
  public class ComboBoxList extends Popover
  {
    public function ComboBoxList()
    {
      _list = new Menu();
    }
    private var _list:Menu;

    public function get list():Menu
    {
    	return _list;
    }

    override public function addedToParent():void{
      super.addedToParent();
      addElement(_list);
    }

    public function set list(value:Menu):void
    {
    	_list = value;
    }
  }
}