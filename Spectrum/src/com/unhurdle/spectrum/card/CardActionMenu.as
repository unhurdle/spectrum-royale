package com.unhurdle.spectrum.card
{
  import com.unhurdle.spectrum.ActionMenu;
  import com.unhurdle.spectrum.Group;
  import org.apache.royale.events.Event;
  import com.unhurdle.spectrum.Popover;
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  [Event(name="change", type="org.apache.royale.events.Event")]
  [Event(name="beforeShow", type="org.apache.royale.events.Event")]
  public class CardActionMenu extends Group
  {
    public function CardActionMenu()
    {
      super();
    }
    override protected function getSelector():String{
      return getCardSelector() + "-actionButton";
    }
    public var menu:ActionMenu;

    private function handleChange(event:Event):void{
	    dispatchEvent(event);
    }

    private function handleBeforeShow(event:Event):void{
      dispatchEvent(new Event("beforeShow"));
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement =  addElementToWrapper(this,'div');
      menu = new ActionMenu();
      //change should bubble automatically
      menu.addEventListener("change",handleChange)
      menu.addEventListener("beforeShow",handleBeforeShow)
      addElement(menu);
      return elem;
    }

    public function get dataProvider():Object{
      return menu.dataProvider;
    }

    public function set dataProvider(value:Object):void{
      menu.dataProvider = value;
    }

		public function get alignRight():Boolean
		{
			return menu.alignRight;
		}

		public function set alignRight(value:Boolean):void
		{
			menu.alignRight = value;
		}
    public function get selectable():Boolean
    {
    	return menu.selectable;
    }

    public function set selectable(value:Boolean):void
    {
    	menu.selectable = value;
    }

    public function get selectedIndex():int
    {
      return menu.selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
        menu.selectedIndex = value;
    }
    private var _selectedItem:Object;

    public function get selectedItem():Object
    {
        return menu.selectedItem;
    }

    public function set selectedItem(value:Object):void
    {
        menu.selectedItem = value;
    }
    public function get text():String
    {
    	return menu.text;
    }

    public function set text(value:String):void
    {
    	menu.text = value;
    }

    /**
     * Icon selector name
     */
    public function get icon():String
    {
    	return menu.icon;
    }

    public function set icon(value:String):void
    {
    	menu.icon = value;
    }


    public function get iconClass():String
    {
    	return menu.iconClass;
    }

    public function set iconClass(value:String):void
    {
    	menu.iconClass = value;
    }

    public function get iconSize():String
    {
    	return menu.iconSize;
    }

    public function set iconSize(value:String):void
    {
    	menu.iconSize = value;
    }

    public function get iconType():String
    {
    	return menu.iconType;
    }

    public function set iconType(value:String):void
    {
    	menu.iconType = value;
    }

    public function get quiet():Boolean
    {
    	return menu.quiet;
    }

    public function set quiet(value:Boolean):void
    {
    	menu.quiet = value;
    }

    public function get disabled():Boolean
    {
      return menu.disabled;
    }

    public function set disabled(value:Boolean):void
    {
      menu.disabled = value;
    }

    public function get invalid():Boolean
    {
    	return menu.invalid;
    }

    public function set invalid(value:Boolean):void
    {
    	menu.invalid = value;
    }
    
    public function get selected():Boolean
    {
    	return menu.selected;
    }

    public function set selected(value:Boolean):void
    {
    	menu.selected = value;
    }

    public function get popover():Popover
    {
    	return menu.popover;
    }

  }
}