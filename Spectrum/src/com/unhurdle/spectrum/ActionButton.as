package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
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


    private var flyOutIconHolder:Icon;

    private function createFlyoutIcon():void{
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

    private var _selected:Boolean = false;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
      if(!!value != _selected){
      	_selected = value;
        toggle("is-selected",value);
      }
    }

    private function elementClicked(ev:Event):void{
      selected = !selected;
    }
    private function elementClickedForMenu(ev:Event):void{
      if(popup && popup.open){
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
      timer.start();
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
    public function showMenu():void{
      // construct if necessary and show the menu.
      if(!popup){
        popup = new ComboBoxList();
        menu = popup.list;
        menu.dataProvider = dataProvider;
        menu.addEventListener("change",handleMenuChange);
      }
      var origin:Point = new Point(width, height);
      var relocated:Point = PointUtils.localToGlobal(origin,this);
      popup.x = relocated.x
      popup.y = relocated.y;

			var popupHost:IPopUpHost = UIUtils.findPopUpHost(this);
			popupHost.popUpParent.addElement(popup);
      popup.open = true;
			popup.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			callLater(function():void {
				popup.topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
			});
    }
    private var menu:Menu;
    private var popup:ComboBoxList;

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
    private function closePopup():void{
      if(popup && popup.open){
  			popup.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
	  		this.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		  	popup.topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
        UIUtils.removePopUp(popup);
        popup.open = false;
      }
    }
		
  }
}