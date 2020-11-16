package com.unhurdle.spectrum
{
  import org.apache.royale.core.IPopUp;

  public class ComboBoxList extends Popover implements IPopUp
  {
    public function ComboBoxList()
    {
      _list = new Menu();
      floating = true;
      tabFocusable = false;
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
    override public function set tabFocusable(value:Boolean):void
    {
    	_tabFocusable = value;
      if(value){
        setAttribute("tabindex",0);
      } else {
        setAttribute("tabindex",-1);
      }
    }
    override public function set open(value:Boolean):void{
      super.open = value;
      if(value){
        _list.focus();
      } else {
        _list.blur();
      }
    }

  }
}