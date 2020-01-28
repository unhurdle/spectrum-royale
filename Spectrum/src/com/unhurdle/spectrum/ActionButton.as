package com.unhurdle.spectrum
{
  COMPILE::JS
  {
  }
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.utils.Timer;
  import org.apache.royale.utils.UIUtils;
  import org.apache.royale.core.IPopUpHost;
  import org.apache.royale.geom.Point;
  import org.apache.royale.utils.PointUtils;
  import org.apache.royale.events.Event;
  import org.apache.royale.utils.callLater;
  import com.unhurdle.spectrum.const.IconType;

	[Event(name="change", type="org.apache.royale.events.Event")]
	[Event(name="selectionChanged", type="org.apache.royale.events.Event")]
  public class ActionButton extends Button
  {
    public function ActionButton()
    {
      super()
      toggle(valueToSelector("primary"),false);
      addEventListener('click',elementClickedForMenu,true);
      addEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown);
    }
    override protected function getSelector():String{
      return "spectrum-ActionButton";
    }

    override public function set flavor(value:String):void{
      // do nothing
    }


    protected var flyOutIconHolder:Icon;

    protected function createFlyoutIcon():void{
      if(!flyOutIconHolder){
        var type:String = IconType.CORNER_TRIANGLE;
        flyOutIconHolder = new Icon(Icon.getCSSTypeSelector(type));
        flyOutIconHolder.type = type;
        flyOutIconHolder.className = appendSelector("-hold");
        addElement(flyOutIconHolder);
        timer = new Timer(1000,1);
        timer.addEventListener(Timer.TIMER,onTimer);

      }
    }

    private var _selectable:Boolean;

    public function get selectable():Boolean
    {
    	return _selectable;
    }

    public function set selectable(value:Boolean):void
    {
    	_selectable = value;
    }

    override public function addedToParent():void{
      super.addedToParent();
      if(selectable){
        addEventListener('click',elementClicked);
        // element.onclick = elementClicked;
      }
      addEventListener(MouseEvent.MOUSE_DOWN,elementMouseDown);
      if(dataProvider){
        createFlyoutIcon();
      }
    }

    // private var _selected:Boolean = false;

    // public  function get selected():Boolean
    // {
    //   return _selected;
    // }

    // public  function set selected(value:Boolean):void
    // {
    //   if(!!value != _selected){
    //   	_selected = value;
    //     toggle("is-selected",value);
    //   }
    // }

    private function elementClicked(ev:Event):void{
      selected = !selected;
      dispatchEvent(new Event("selectionChanged"));
    }
    private function elementClickedForMenu(ev:Event):void{
      if(popover && popover.open){
        ev.stopImmediatePropagation();
      }
    }
    private function elementMouseDown(ev:Event):void{
      closePopup();
    }

    private var _selectedIndex:int;

    public function get selectedIndex():int
    {
      if(menu){
        return menu.selectedIndex;
      }
    	return _selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
      if(menu){
        menu.selectedIndex = value;
      }
    	_selectedIndex = value;
    }
    private var _selectedItem:Object;

    public function get selectedItem():Object
    {
      if(menu){
        return menu.selectedItem;
      }
      if(_selectedIndex >=0 && dataProvider && _selectedIndex < dataProvider["length"]){
        if(dataProvider is Array){
          return dataProvider[_selectedIndex];
        }
        return dataProvider["source"][_selectedIndex];
      }
    	return null;
    }

    public function set selectedItem(value:Object):void
    {
      if(menu){
        menu.selectedItem = value;
      }
      if(dataProvider is Array){
        _selectedIndex = (dataProvider as Array).indexOf(value);
      }
      if(dataProvider.hasOwnProperty("source")){
        _selectedIndex = dataProvider["source"]["indexOf"](value);
      }
    	_selectedIndex = -1;
    }

    private var _dataProvider:Object;

    public function get dataProvider():Object
    {
    	return _dataProvider;
    }

    public function set dataProvider(value:Object):void
    {
    	_dataProvider = value;
      createFlyoutIcon();
      if(menu){
        menu.dataProvider = value;
      }
    }

    private function handleMouseDown(ev:*):void{
  		window.addEventListener('mouseup', handleMouseUp);
      if(timer){
        timer.start();
      }
    }

    private function handleMouseUp(ev:*):void{
  		window.removeEventListener('mouseup', handleMouseUp);
      if(timer){
        timer.reset();
      }
    }

    private var timer:Timer;

    private function onTimer(ev:*):void{
      timer.reset();
      showMenu();
    }
    public function createPopover():void{
      popover = new ComboBoxList();
      menu = popover.list;
      menu.dataProvider = dataProvider;
      menu.addEventListener("change",handleMenuChange);
    }
    public function showMenu():void{
      // construct if necessary and show the menu.
      if(!popover){
        createPopover();
      }
      dispatchEvent(new Event("beforeShow"));
			var popupHost:IPopUpHost = UIUtils.findPopUpHost(this);
      popover.open = true;
      positionPopup();
			popover.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			callLater(function():void {
				popover.topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
			});
    }
    protected function positionPopup():void{
      var origin:Point = new Point(width, height);
      var relocated:Point = PointUtils.localToGlobal(origin,this);
      popover.x = relocated.x
      popover.y = relocated.y;

    }
    public var menu:Menu;
    public var popover:ComboBoxList;

    private function handleMenuChange(ev:Event):void{
      closePopup();
      dispatchEvent(new Event("change"));
    }
		protected function handleControlMouseDown(event:MouseEvent):void
		{			
			event.stopImmediatePropagation();
		}
		
		protected function handleTopMostEventDispatcherMouseDown(event:MouseEvent):void
		{
      closePopup();
		}
    protected function closePopup():void{
      if(popover && popover.open){
  			popover.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
	  		this.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		  	popover.topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
        popover.open = false;
      }
    }
		
  }
}