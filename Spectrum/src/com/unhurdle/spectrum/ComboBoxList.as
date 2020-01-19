package com.unhurdle.spectrum
{
  import org.apache.royale.core.IPopUp;

  public class ComboBoxList extends Popover implements IPopUp
  {
    public function ComboBoxList()
    {
      _list = new Menu();
      floating = true;
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